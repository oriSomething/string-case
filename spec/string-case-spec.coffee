###
Tests
===
- Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.

###
StringCase = require("../lib/string-case")

log = (t) -> console.warn(t)

describe "StringCase", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage("string-case")

    waitsForPromise ->
      atom.workspace.open()

  it "it converts to camel case", ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText("cool-text")
    editor.selectAll()

    changeHandler = jasmine.createSpy("changeHandler")
    editor.onDidChange(changeHandler)
    atom.commands.dispatch(workspaceElement, "string-case:camelcase")

    waitsForPromise ->
      activationPromise
    waitsFor ->
      changeHandler.callCount > 0
    runs ->
      expect(editor.getText()).toEqual("coolText")

  it "it converts to pascal case", ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText("cool-text")
    editor.selectAll()

    changeHandler = jasmine.createSpy("changeHandler")
    editor.onDidChange(changeHandler)
    atom.commands.dispatch(workspaceElement, "string-case:pascalcase")

    waitsForPromise ->
      activationPromise
    waitsFor ->
      changeHandler.callCount > 0
    runs ->
      expect(editor.getText()).toEqual("CoolText")

  it "it converts to kebab case", ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText("CoolText")
    editor.selectAll()

    changeHandler = jasmine.createSpy("changeHandler")
    editor.onDidChange(changeHandler)
    atom.commands.dispatch(workspaceElement, "string-case:kebabcase")

    waitsForPromise ->
      activationPromise
    waitsFor ->
      changeHandler.callCount > 0
    runs ->
      expect(editor.getText()).toEqual("cool-text")

  it "it converts to snake case", ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText("cool-text")
    editor.selectAll()

    changeHandler = jasmine.createSpy("changeHandler")
    editor.onDidChange(changeHandler)
    atom.commands.dispatch(workspaceElement, "string-case:snakecase")

    waitsForPromise ->
      activationPromise
    waitsFor ->
      changeHandler.callCount > 0
    runs ->
      expect(editor.getText()).toEqual("cool_text")

  it "it converts word when the cursor is located inside a wrod", ->
    editor = atom.workspace.getActiveTextEditor()
    editor.insertText("cool_text")
    editor.moveLeft(1)

    changeHandler = jasmine.createSpy("changeHandler")
    editor.onDidChange(changeHandler)
    atom.commands.dispatch(workspaceElement, "string-case:pascalcase")

    waitsForPromise ->
      activationPromise
    waitsFor ->
      changeHandler.callCount > 0
    runs ->
      expect(editor.getText()).toEqual("CoolText")
