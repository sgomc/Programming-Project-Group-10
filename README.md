
---

# Flight Management System

**An interactive application for managing and visualizing flight data, developed as a group project.**


## ✨ Project Vision

The **VAST Map Project** is designed to provide easy access to flight data across the USA, helping users arrange or analyze flights efficiently. Our team of five — **Veronika, Maccolins, Amy, Stephen, and Thomas** — worked hard to make this project accessible, smooth, and dynamic. With features like an interactive map and a statistics page, we’ve aimed to make the project as *vast* as possible.

We sincerely thank you for giving it a try.


## Overview

This project is a flight management system that allows users to view and manage flight information, including departures, arrivals, and statistics. The application provides a graphical user interface (GUI) for interacting with various components such as airports, flights, and cities.

## Features

* Display of departures and arrivals
* Visualization of airports and cities
* Interactive GUI components like buttons, checkboxes, and tabs
* Search functionality for flights
* Statistical analysis of flight data
* Loading screens and main menu navigation
* About window with project information

## File Structure

* `Main.pde`: Entry point of the application
* `Airport.pde`, `City.pde`, `Flight.pde`, `Plane.pde`: Classes representing core entities
* `DeparturesArrivals.pde`: Handles the display of departures and arrivals
* `Statistics.pde`, `StatisticsWindow.pde`: Manage and display statistical data
* `MainMenu.pde`, `AboutWindow.pde`: GUI components for navigation and information
* `Button.pde`, `CheckBox.pde`, `RadioButton.pde`, `Tab.pde`, `Searchbar.pde`: Custom GUI elements
* `Constants.pde`: Contains constant values used throughout the application
* `StateFunctions.pde`: Manages different states of the application
* `LoadingScreenMethod.pde`: Implements the loading screen functionality
* `Window.pde`: Base class for window components
* `data/`: Directory containing data files used by the application
* `ABOUT.txt`: Information about the project
* `ROLES.txt`: Describes the roles of team members
* `TA's for everyone.txt`: Acknowledgments or notes for teaching assistants

## Getting Started

To run the application:

1. Ensure you have [Processing](https://processing.org/download/) installed.
2. Download or clone the repository:

   ```bash
   git clone https://github.com/sgomc/Programming-Project-Group-10.git
   ```
3. Open the `Programming-Project-Group-10` folder in Processing.
4. Run the `Main.pde` file.

## License

This project is licensed under the [MIT License](LICENSE).

---

Feel free to customize this `README.md` to better fit your project's specifics. If you need assistance with any part of the application or further customization, don't hesitate to ask!
