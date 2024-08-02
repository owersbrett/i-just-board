import SwiftUI
import Cocoa


struct EditableTextField: View {
    @State private var isEditing: Bool = false
    @Binding var text: String
    @EnvironmentObject var windowSize: WindowSize
    
    let viewEnum: ViewEnum

    var onSubmit: ((String) -> Void)?
    
    // Define a font size variable
    var fontSize: CGFloat = 24
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            if isEditing {
                EditableTextView(text: $text, fontSize: fontSize, onSubmit: onSubmit) {
                    isEditing = false
                    isFocused = false
                }
                .frame(width: (viewEnum == .board ? windowSize.size.width / 2 : windowSize.size.width * 0.15), height:  (viewEnum == .column ? 48 : windowSize.size.height * 0.15 ))
                .background(
                    RoundedRectangle(cornerRadius: 24)
                )
                .focused($isFocused)
                .onAppear {
                    isFocused = true
                }
                .onChange(of: isFocused) { _, focused in
                    if !focused {
                        isEditing = false
                        onSubmit?(text)
                    }
                }
                .onSubmit {
                    onSubmit?(text)
                    isEditing = false
                }
            } else {
                Text(text)
                    .font(.system(size: fontSize)) // Set the font size for the Text
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .onTapGesture {
                        isEditing = true
                    }
            }
        }
        .contentShape(
                    RoundedRectangle(cornerRadius: 24) // Use a RoundedRectangle for contentShape
                )        .onTapGesture {
            if isEditing {
                isFocused = false
            }
        }
    }
}

struct EditableTextView: NSViewControllerRepresentable {
    @EnvironmentObject var windowSize: WindowSize
    @Binding var text: String
    var fontSize: CGFloat = 24
    var onSubmit: ((String) -> Void)?
    var onExitFocus: (() -> Void)?

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: EditableTextView

        init(parent: EditableTextView) {
            self.parent = parent
        }

        func textDidChange(_ notification: Notification) {
            if let textView = notification.object as? NSTextView {
                parent.text = textView.string
            }
        }

        func textDidEndEditing(_ notification: Notification) {
            if let textView = notification.object as? NSTextView {
                parent.onSubmit?(textView.string)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeNSViewController(context: Context) -> NSViewController {
        let viewController = NSViewController()
        
        // Create an NSScrollView to contain the NSTextView
        let scrollView = NSScrollView(frame: NSMakeRect(0, 0, windowSize.size.width * 0.10, windowSize.size.height * 0.10))
        scrollView.hasVerticalScroller = false
        scrollView.hasHorizontalScroller = false
        scrollView.wantsLayer = true
        scrollView.layer?.cornerRadius = 20
        scrollView.layer?.masksToBounds = true
        
        // Create the CustomTextView and set it as the document view of the scroll view
        let textView = CustomTextView(frame: NSMakeRect(0, 0, scrollView.contentSize.width, scrollView.contentSize.height))
        textView.delegate = context.coordinator
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        textView.autoresizingMask = [.width]
        textView.backgroundColor = .clear // Set background color to clear to avoid overlap
                textView.drawsBackground = false  // Ensure the background isn't drawn to avoid overlapping
                
        textView.textContainerInset = NSSize(width: 8, height: 8)

        textView.font = NSFont.systemFont(ofSize: fontSize)
        textView.string = text
        textView.onEnterPressed = {
            self.onExitFocus?()
        }
        
        // Apply rounded corners to the NSTextView
        textView.wantsLayer = true
        textView.layer?.cornerRadius = 20
        textView.layer?.masksToBounds = true
        
        scrollView.documentView = textView
        
        // Add the scroll view (which contains the text view) to the view controller's view
        viewController.view = scrollView
        
        return viewController
    }

    func updateNSViewController(_ nsViewController: NSViewController, context: Context) {
        if let scrollView = nsViewController.view as? NSScrollView,
           let textView = scrollView.documentView as? CustomTextView {
            textView.string = text
            textView.font = NSFont.systemFont(ofSize: fontSize)
        }
    }
}

class CustomTextView: NSTextView {
    var onEnterPressed: (() -> Void)?

    override func keyDown(with event: NSEvent) {
           let shiftPressed = event.modifierFlags.contains(.shift)
           
           if event.keyCode == 36 && !shiftPressed { // Enter key code without Shift
               onEnterPressed?()
               self.window?.makeFirstResponder(nil)
           } else {
               super.keyDown(with: event)
           }
       }
}
