# CACHING YOUR GITHUB PASSWORD IN GIT

If you're cloning GitHub repositories using HTTPS, you can use a credential helper to tell Git to remember your GitHub username and password every time it talks to GitHub.

## MAC

1.	Find out if Git and the osxkeychain helper are already installed:

	```bash
	$ git credential-osxkeychain
	# Test for the cred helper
	Usage: git credential-osxkeychain <get|store|erase>
	```

2.	If the `osxkeychain helper` isn't installed and you're running OS X version 10.9 or above, your computer will prompt you to download it as a part of the Xcode Command Line Tools:

	```bash
	$ git credential-osxkeychain
	xcode-select: note: no developer tools were found at '/Applications/Xcode.app', requesting install.
	Choose an option in the dialog to download the command line developer tools.
	```

	Alternatively, you can install Git and the `osxkeychain helper` by using [Homebrew](http://brew.sh/):

	```bash
	$ brew install git
	```

3.	Tell Git to use `osxkeychain helper` using the global `credential.helper` config:

	```bash
	$ git config --global credential.helper osxkeychain
	# Set git to use the osxkeychain credential helper
	```

## LINUX

Set git to use the credential memory cache:

```bash
$ git config --global credential.helper cache
```

Set the cache to timeout after 2 hour (setting is in seconds)

```bash
$ git config --global credential.helper 'cache --timeout=7200'
```

## WINDOWS

The credential helper is included with GitHub Desktop. The app also provides a Git shell so you won't ever need to install and configure Git manually. For more information, see "[Getting Started with GitHub Desktop](https://help.github.com/desktop/guides/getting-started/)."

If you prefer working with the command line, you can also install a native Git shell, such as Git for Windows. With [Git for Windows](https://git-for-windows.github.io/), running the following in the command line will store your credentials:

```bash
$ git config --global credential.helper wincred
```

The next time you clone an HTTPS URL that requires a password, you'll be prompted for your username and password, and to grant access to the OSX keychain. After you've done this, the username and password are stored in your keychain and you won't be required to type them in to Git again.

For information about setting SSH keys visit the page ["Generating a new SSH key and adding it to the ssh-agent".](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-mac)

# DELETING YOUR GITHUB CREDENTIALS FROM THE OSX KEYCHAIN VIA THE COMMAND LINE

Through the command line, you can use the credential helper directly to erase the keychain entry.

To do this, type the following command:

```bash
git credential-osxkeychain erase
host=github.com
protocol=https
[Press Return]
```

If it's successful, nothing will print out. To test that it works, try and clone a repository from GitHub. If you are prompted for a password, the keychain entry was deleted.

# CONFIGURE BASH TO SHOW THE GIT STATUS OF A REPOSITORY

Place the following lines in the file `${OS_PATH}/dotbashrc-debuntu` or `${OS_PATH}/dotbashrc-macos`

```bash
if [ -f $HOME/git-completion.bash ]; then
	source "$HOME/git-completion.bash"
	source "$HOME/git-prompt.sh"
	export GIT_PS1_SHOWDIRTYSTATE=1
	green="\[\033[0;32m\]"
	blue="\[\033[0;34m\]"
	purple="\[\033[0;35m\]"
	reset="\[\033[0m\]"
	export PS1="$purple\u$green\$(__git_ps1)$blue \W $ $reset"
fi
```

'\u' adds the name of the current user to the prompt
'\$(\__git_ps1)' adds git-related stuff
'\W' adds the name of the current directory

Original line

```bash
export PS1="$purple\u@\h: $blue\W $green\$(\__git_ps1) $reset\$ "
```

# [GENERATING A NEW SSH KEY AND ADDING IT TO THE SSH-AGENT](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-mac)

After you've checked for existing SSH keys, you can generate a new SSH key to use for authentication, then add it to the ssh-agent.

If you don't already have an SSH key, you must [generate a new SSH key](#generating-a-new-ssh-key). If you're unsure whether you already have an SSH key, check for [existing keys](https://help.github.com/articles/checking-for-existing-ssh-keys).

If you don't want to reenter your passphrase every time you use your SSH key, you can [add your key to the SSH agent](#adding-your-ssh-key-to-the-ssh-agent), which manages your SSH keys and remembers your passphrase.

## [GENERATING A NEW SSH KEY](#generating-a-new-ssh-key)

1. Open Terminal (in MacOs/Linux) or Git Bash (in Windows)

2. Paste the text below, substituting in your GitHub email address.

   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

   This creates a new ssh key, using the provided email as a label.

   ```bash
    Generating public/private rsa key pair.</span>
    ```

3. When you are prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.

   * In MacOs:

   ```bash
   Enter a file in which to save the key (/Users/_you_/.ssh/id_rsa): [Press enter]
   ```

   * In Linux:

   ```bash
   Enter a file in which to save the key (/home/_you_/.ssh/id_rsa): [Press enter]
   ```

   * In Windows:

   ```bash
   Enter a file in which to save the key (/c/Users/_you_/.ssh/id_rsa) :[Press enter]
   ```

4. At the prompt, type a secure passphrase. For more information, see ["Working with SSH key passphrases"](https://help.github.com/articles/working-with-ssh-key-passphrases).

   ```bash
   Enter passphrase (empty for no passphrase): [Type a passphrase]
   Enter same passphrase again: [Type passphrase again]
   ```

## ADDING YOUR SSH KEY TO THE SSH-AGENT

Before adding a new SSH key to the ssh-agent to manage your keys, you should have [checked for existing SSH keys](https://help.github.com/articles/checking-for-existing-ssh-keys) and [generated a new SSH key](#generating-a-new-ssh-key).

* MacOS:

When adding your SSH key to the agent, use the default macOS `ssh-add` command, and not an application installed by [macports](https://www.macports.org/), [homebrew](http://brew.sh/), or some other external source.

1. Start the ssh-agent in the background.

```bash
eval "$(ssh-agent -s)"
Agent pid 59566
```

2. If you're using macOS Sierra 10.12.2 or later, you will need to modify your `~/.ssh/config` file to automatically load keys into the ssh-agent and store passphrases in your keychain.

```bash
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
```

3. Add your SSH private key to the ssh-agent and store your passphrase in the keychain. If you created your key with a different name, or if you are adding an existing key that has a different name, replace _id_rsa_ in the command with the name of your private key file.

```bash
$ ssh-add -K ~/.ssh/id_rsa
```

4. [Add the SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account).

* Linux:

1. Start the ssh-agent in the background.

  ```bash
  eval "$(ssh-agent -s)
  Agent pid 59566
  ```

2. Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you are adding an existing key that has a different name, replace _id_rsa_ in the command with the name of your private key file.

   ```bash
    ssh-add ~/.ssh/id_rsa
    ```

3. [Add the SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account).

* Windows:

If you have [GitHub Desktop](https://desktop.github.com/) installed, you can use it to clone repositories and not deal with SSH keys. It also comes with the Git Bash tool, which is the preferred way of running `git` commands on Windows.

1. Ensure the ssh-agent is running:

   * If you are using the Git Shell that's installed with GitHub Desktop, the ssh-agent should be running.
   * If you are using another terminal prompt, such as Git for Windows, you can use the "Auto-launching the ssh-agent" instructions in "[Working with SSH key passphrases](/articles/working-with-ssh-key-passphrases)", or start it manually:

   ```bash
   start the ssh-agent in the background
   eval $(ssh-agent -s)
   Agent pid 59566
   ```

2. Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you are adding an existing key that has a different name, replace _id_rsa_ in the command with the name of your private key file.

   ```bash
   ssh-add ~/.ssh/id_rsa
   ```

3. [Add the SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account).

## FURTHER READING

* "[About SSH](https://help.github.com/articles/about-ssh)"
* "[Working with SSH key passphrases](https://help.github.com/articles/working-with-ssh-key-passphrases)"
* "[Authorizing an SSH key for use with a SAML single sign-on organization](https://help.github.com/articles/authorizing-an-ssh-key-for-use-with-a-saml-single-sign-on-organization)"
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTk1OTQ4MDE3N119
-->
