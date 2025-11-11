1. What issues prevent us from using storyboards in real projects??
   First of all, it’s hard to resolve merge conflicts in Storyboards as it's just an XML file, that is difficult for reading
   Secondly, it is imposible to use hand-made inisializators for UIViewControllers
   
2. What does the code on lines 25 and 29 do?
   
   title.translatesAutoresizingMaskIntoConstraints = false
   \\ that's means we will need to set layout constraints manually

   title.attributedText = viewModel.title
   \\ sets the label’s text with an attributed string (instead of plain text), so styles like font, color, underline, can be applied

   title.textAlignment = .center
   \\ aligns the text inside the label to the center.

   view.addSubview(title)
   \\ adds the label (title) as a child of the main view, so it actually appears on screen.

3. What is safe area layout guide?
   It's area where content can safely appear without being obscured by system UI elements

4. What is [weak self] on line 23 and why is is important?
   [weak self] in Swift is a way of using closures where a weak reference to self (the current instance of the class) is created instead of a strong one. This is necessary to prevent memory leaks caused by retain cycles between objects. A weak reference does not increase the reference count of the object, allowing it to be deallocated when no longer needed, thus avoiding objects from retaining each other in a loop.

5. What does clipsToBounds mean?
   clipsToBounds is used to hide any content that goes outside the edges of a view

6. What is the valueChanged type? What is Void and what is Double?
   the type of valueChanged is: (Double) -> Void
   Double → the slider’s current numeric value
   Void → nothing is returned from the closure
   
