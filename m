Return-Path: dave@gnu.org
Subject: [PATCH] Documentation: add debugging doc
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 06 Aug 2011 20:59:32 -0400
Message-ID: <1312678772.3408.3.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Layout the base for tips on debugging util-linux programs/wrappers.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 Documentation/README.debug |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/README.debug

diff --git a/Documentation/README.debug b/Documentation/README.debug
new file mode 100644
index 0000000..7ead12f
--- /dev/null
+++ b/Documentation/README.debug
@@ -0,0 +1,30 @@
+Debugging util-linux programs
+-----------------------------
+
+There are considerations to be made when profiling or debugging some programs found
+in the util-linux package. Because wrapper scripts are used for the binaries to make
+sure all library dependencies are met, you cannot use tools such as gdb or valgrind
+directly with them.
+
+Let's take for example the mount command:
+
+$> file /path/util-linux/mount/mount
+mount: Bourne-Again shell script text executable
+
+The binary itself is located in the .libs/ dir:
+
+$> file /path/util-linux/mount/.libs/mount
+mount: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.15, not stripped
+
+When this command is run, there's a library dependency error:
+./mount: /lib/x86_64-linux-gnu/libblkid.so.1: version `BLKID_2.20' not found (required by ./mount)
+
+To overcome this we need set the LD_LIBRARY_PATH variable to read the path of the shared lib found in
+the sources, and not system-wide:
+
+$> export LD_LIBRARY_PATH=/path/util-linux/libblkid/src/.libs/:$LD_LIBRARY_PATH
+
+Now external debugging tools can be run on the binary.
+
+Happy hacking!
+Davidlohr Bueso, August 2011
-- 
1.7.4.1
