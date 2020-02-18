
## [HOW TO ADD A INCLUDE DIRECTORY IN ECLIPSE CDT](https://codeyarns.com/2013/09/22/how-to-add-include-directory-in-eclipse-cdt/)

Many C/C++ projects may have to use header files that are not placed in the standard include directories. In some projects, the include files of the project itself are placed in one or more separate directories. For all such cases, you need to indicate Eclipse CDT to add these include directories to the compilation. Else your compilation fails with the error that an included header file cannot be found.

To add an include directory to your project in Eclipse CDT:

1. Right-click on the project name in the `Project Explorer`, choose `Properties > C/C++ General > Paths and Symbols > includes`
2. In the box labeled `Languages` select `GNU C++`. For C files choose Languages `GNU C`.
3. Click the `Add` button and add the include directory. If you want to add multiple include directories, add them separately like this.

Thanks Code Yarns ;P

## [HOW TO ADD A LIBRARY PATH IN ECLIPSE CDT](https://codeyarns.com/2013/09/22/how-to-add-library-path-in-eclipse-cdt/)

A C/C++ project may need to be linked with library files that are not placed in the standard library path locations. To indicate to the compiler to search these paths, you typically use the compiler option `-L`. For example, the option `-L/usr/local/foobar` makes the compiler search the directory `/usr/local/foobar` for library files to link with your program.

Similarly, to add a library path to the compilation of your project in Eclipse CDT:

1. Right-click on the project name in `Project Explorer`, choose `Properties > C/C++ General > Paths and Symbols > Library Paths`.
2. Click the `Add` button and add the library path. For example, add /usr/local/foobar. If you want to add multiple paths, add them separately like this.

Thanks Code Yarns ;P

## [HOW TO ADD A LIBRARY FILE IN ECLIPSE CDT](https://codeyarns.com/2013/09/22/how-to-add-library-in-eclipse-cdt/)

The source code of a C/C++ project may need to be linked with an external shared library file. When compiling from the commandline, this is typically linked using the compiler option `-l`. For example, to link with a library file named `libfoobar.so`, which is placed in one of the standard library paths, you use the option `-lfoobar`. As you can see, the lib prefix and the file extension `.so` do not need to be specified.

Similarly, to add a library file to be linked in Eclipse CDT:

1. Right-click on the project name in `Project Explorer`, choose `Properties > C/C++ General > Paths and Symbols > Libraries`.
2. Click the `Add` button and add library file.

Thanks Code Yarns ;P
