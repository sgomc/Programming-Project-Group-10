class Flight {
    String flightNumber, departureTime, arrivalTime, destination, date;

    Flight(String flightNumber, String departureTime, String arrivalTime, String destination, String date) {
        this.flightNumber = flightNumber;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.destination = destination;
        this.date = date;
    }

    public String toString() {
        return flightNumber + " | " + departureTime + " | " + arrivalTime + " | " + destination + " | " + date;
    }
}
