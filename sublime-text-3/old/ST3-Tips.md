# Get packages and its URLs in Sublime Text console
import os; [(os.path.dirname(file)[len('Packages/'):], sublime.decode_value(sublime.load_resource(file))['url']) for file in sublime.find_resources('package-metadata.json')]
