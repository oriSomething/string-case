/** @babel */
/* global atom */
import { CompositeDisposable } from "atom";
import camelcase from "lodash.camelcase";
import kebabcase from "lodash.kebabcase";
import snakecase from "lodash.snakecase";
import pascalcase from "./pascalcase";


export default {
  REGEX: /[\w_-]+/g,

  subscriptions: null,

  /** @event */
  activate() {
    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();
    this.subscriptions.add(atom.commands.add("atom-workspace", {
      "string-case:camelcase": this.camel.bind(this),
      "string-case:kebabcase": this.kebab.bind(this),
      "string-case:pascalcase": this.pascal.bind(this),
      "string-case:snakecase": this.snake.bind(this)
    }));
  },

  /** @event */
  deactivate() {
    this.subscriptions.dispose();
  },

  transformSelections(regex, fn) {
    const activeText = atom.workspace.getActiveTextEditor();

    if (!activeText) return;

    activeText.getSelections()
      .forEach(selection => {
        let text = selection.getText();

        if (text === "") {
          const range = selection.selectWord();
          text = activeText.getTextInBufferRange(range);
          text = text.replace(regex, fn);
          activeText.setTextInBufferRange(range, text);
        } else {
          text = text.replace(regex, fn);
          selection.insertText(text, {
            select: true
          });
        }
      });
  },

  camel() {
    this.transformSelections(this.REGEX, camelcase);
  },

  kebab() {
    this.transformSelections(this.REGEX, kebabcase);
  },

  pascal() {
    this.transformSelections(this.REGEX, pascalcase);
  },

  snake() {
    this.transformSelections(this.REGEX, snakecase);
  }
};
