import tkinter as tk

def get_input():
    user_input = entry.get()
    print("User input:", user_input)
    root.destroy()  # Close the window after getting input

# Create the main window
root = tk.Tk()
root.title("PIN")

# Create a label
label = tk.Label(root, text="Enter your PIN:")
label.pack()

# Create an entry widget (textbox) with a wider width
entry = tk.Entry(root, width=40)  # Set the width to 50 characters
entry.pack()

# Create a button to submit the input
submit_button = tk.Button(root, text="Submit", command=get_input)
submit_button.pack()

# Run the main event loop
root.mainloop()
