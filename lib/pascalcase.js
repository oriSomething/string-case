/** @babel */
import camelcase from "lodash.camelcase";
import capitalize from "lodash.capitalize";


export default function pascalcase(text) {
  return capitalize(camelcase(text));  
}
