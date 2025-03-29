import java.util.Objects;

class Airport {
  String name, city, state;

  Airport(String name, String city, String state) {
    this.name = name;
    this.city = city;
    this.state = state;
  }

  public String toString() {
    return name + " — " + city;
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj) return true;
    if (obj == null || getClass() != obj.getClass()) return false;
    Airport airport = (Airport) obj;
    return Objects.equals(name, airport.name) &&  // Use a unique identifier
      Objects.equals(state, airport.state);
  }

  @Override
  public int hashCode() {
    return Objects.hash(name, state);
  }
}
