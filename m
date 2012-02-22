Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42975 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab2BVV3I (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 22 Feb 2012 16:29:08 -0500
Received: by eekc4 with SMTP id c4so83738eek.19
        for <util-linux@vger.kernel.org>; Wed, 22 Feb 2012 13:29:05 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] docs: corrections to FSF license files, and postal address
Date: Wed, 22 Feb 2012 22:28:48 +0100
Message-Id: <1329946128-6899-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The COPYING and Documentation/licenses/COPYING* files are being
replaced by files from GNU web site.

http://www.gnu.org/licenses/gpl-2.0.txt
http://www.gnu.org/licenses/lgpl-2.1.txt

Postal addresses to FSF in other files are updated to match with the
address in license files.

Reference: http://lists.gnu.org/archive/html/freefont-announce/2005-04/msg00001.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 COPYING                                   |   41 +++++++-------
 Documentation/cfdisk.txt                  |    6 +-
 Documentation/licenses/COPYING.GPLv2      |   42 +++++++-------
 Documentation/licenses/COPYING.LGPLv2.1   |   84 +++++++++++++----------------
 disk-utils/elvtune.c                      |    8 +--
 disk-utils/fsck.cramfs.c                  |    6 +-
 disk-utils/mkfs.cramfs.c                  |    6 +-
 fdisk/cfdisk.c                            |    6 +-
 getopt/getopt.c                           |    6 +-
 lib/path.c                                |    6 +-
 libblkid/src/blkid.h.in                   |    2 +-
 libblkid/src/partitions/blkid_parttypes.h |    2 +-
 libmount/src/libmount.h.in                |    6 +-
 misc-utils/findmnt.c                      |    6 +-
 misc-utils/lsblk.c                        |    6 +-
 misc-utils/wipefs.c                       |    6 +-
 mount/mount.8                             |    7 +--
 mount/umount.8                            |    7 +--
 schedutils/chrt.1                         |    7 +--
 schedutils/chrt.c                         |    6 +-
 schedutils/taskset.1                      |    7 +--
 schedutils/taskset.c                      |    6 +-
 sys-utils/arch.c                          |    3 +-
 sys-utils/chcpu.c                         |    6 +-
 sys-utils/fallocate.c                     |    6 +-
 sys-utils/ipcmk.c                         |    6 +-
 sys-utils/lscpu.c                         |    6 +-
 sys-utils/mount.8                         |    7 +--
 sys-utils/mount.c                         |    6 +-
 sys-utils/mountpoint.c                    |    6 +-
 sys-utils/prlimit.c                       |    6 +-
 sys-utils/readprofile.c                   |    6 +-
 sys-utils/umount.c                        |    6 +-
 sys-utils/unshare.c                       |    2 +-
 34 files changed, 165 insertions(+), 180 deletions(-)

diff --git a/COPYING b/COPYING
index 623b625..d159169 100644
--- a/COPYING
+++ b/COPYING
@@ -1,12 +1,12 @@
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
+                    GNU GENERAL PUBLIC LICENSE
+                       Version 2, June 1991
 
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-     51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
+ 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
-			    Preamble
+                            Preamble
 
   The licenses for most software are designed to take away your
 freedom to share and change it.  By contrast, the GNU General Public
@@ -15,7 +15,7 @@ software--to make sure the software is free for all its users.  This
 General Public License applies to most of the Free Software
 Foundation's software and to any other program whose authors commit to
 using it.  (Some other Free Software Foundation software is covered by
-the GNU Library General Public License instead.)  You can apply it to
+the GNU Lesser General Public License instead.)  You can apply it to
 your programs, too.
 
   When we speak of free software, we are referring to freedom, not
@@ -55,8 +55,8 @@ patent must be licensed for everyone's free use or not licensed at all.
 
   The precise terms and conditions for copying, distribution and
 modification follow.
-
-		    GNU GENERAL PUBLIC LICENSE
+
+                    GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
   0. This License applies to any program or other work which contains
@@ -110,7 +110,7 @@ above, provided that you also meet all of these conditions:
     License.  (Exception: if the Program itself is interactive but
     does not normally print such an announcement, your work based on
     the Program is not required to print an announcement.)
-
+
 These requirements apply to the modified work as a whole.  If
 identifiable sections of that work are not derived from the Program,
 and can be reasonably considered independent and separate works in
@@ -168,7 +168,7 @@ access to copy from a designated place, then offering equivalent
 access to copy the source code from the same place counts as
 distribution of the source code, even though third parties are not
 compelled to copy the source along with the object code.
-
+
   4. You may not copy, modify, sublicense, or distribute the Program
 except as expressly provided under this License.  Any attempt
 otherwise to copy, modify, sublicense or distribute the Program is
@@ -225,7 +225,7 @@ impose that choice.
 
 This section is intended to make thoroughly clear what is believed to
 be a consequence of the rest of this License.
-
+
   8. If the distribution and/or use of the Program is restricted in
 certain countries either by patents or by copyrighted interfaces, the
 original copyright holder who places the Program under this License
@@ -255,7 +255,7 @@ make exceptions for this.  Our decision will be guided by the two goals
 of preserving the free status of all derivatives of our free software and
 of promoting the sharing and reuse of software generally.
 
-			    NO WARRANTY
+                            NO WARRANTY
 
   11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
 FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
@@ -277,9 +277,9 @@ YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
 PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGES.
 
-		     END OF TERMS AND CONDITIONS
-
-	    How to Apply These Terms to Your New Programs
+                     END OF TERMS AND CONDITIONS
+
+            How to Apply These Terms to Your New Programs
 
   If you develop a new program, and you want it to be of the greatest
 possible use to the public, the best way to achieve this is to make it
@@ -303,17 +303,16 @@ the "copyright" line and a pointer to where the full notice is found.
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
-
+    You should have received a copy of the GNU General Public License along
+    with this program; if not, write to the Free Software Foundation, Inc.,
+    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 Also add information on how to contact you by electronic and paper mail.
 
 If the program is interactive, make it output a short notice like this
 when it starts in an interactive mode:
 
-    Gnomovision version 69, Copyright (C) year  name of author
+    Gnomovision version 69, Copyright (C) year name of author
     Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
     This is free software, and you are welcome to redistribute it
     under certain conditions; type `show c' for details.
@@ -336,5 +335,5 @@ necessary.  Here is a sample; alter the names:
 This General Public License does not permit incorporating your program into
 proprietary programs.  If your program is a subroutine library, you may
 consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Library General
+library.  If this is what you want to do, use the GNU Lesser General
 Public License instead of this License.
diff --git a/Documentation/cfdisk.txt b/Documentation/cfdisk.txt
index cb8d865..45728da 100644
--- a/Documentation/cfdisk.txt
+++ b/Documentation/cfdisk.txt
@@ -26,9 +26,9 @@ ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 for more details.
 
-You should have received a copy of the GNU General Public License
-along with cfdisk; if not, write to the Free Software Foundation,
-Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+You should have received a copy of the GNU General Public License along
+with this program; if not, write to the Free Software Foundation, Inc.,
+51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 ___
 Kevin E. Martin               University of North Carolina at Chapel Hill
diff --git a/Documentation/licenses/COPYING.GPLv2 b/Documentation/licenses/COPYING.GPLv2
index a43ea21..d159169 100644
--- a/Documentation/licenses/COPYING.GPLv2
+++ b/Documentation/licenses/COPYING.GPLv2
@@ -1,12 +1,12 @@
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
+                    GNU GENERAL PUBLIC LICENSE
+                       Version 2, June 1991
 
- Copyright (C) 1989, 1991 Free Software Foundation, Inc.
-                          675 Mass Ave, Cambridge, MA 02139, USA
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
+ 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
-			    Preamble
+                            Preamble
 
   The licenses for most software are designed to take away your
 freedom to share and change it.  By contrast, the GNU General Public
@@ -15,7 +15,7 @@ software--to make sure the software is free for all its users.  This
 General Public License applies to most of the Free Software
 Foundation's software and to any other program whose authors commit to
 using it.  (Some other Free Software Foundation software is covered by
-the GNU Library General Public License instead.)  You can apply it to
+the GNU Lesser General Public License instead.)  You can apply it to
 your programs, too.
 
   When we speak of free software, we are referring to freedom, not
@@ -55,8 +55,8 @@ patent must be licensed for everyone's free use or not licensed at all.
 
   The precise terms and conditions for copying, distribution and
 modification follow.
-
-		    GNU GENERAL PUBLIC LICENSE
+
+                    GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
   0. This License applies to any program or other work which contains
@@ -110,7 +110,7 @@ above, provided that you also meet all of these conditions:
     License.  (Exception: if the Program itself is interactive but
     does not normally print such an announcement, your work based on
     the Program is not required to print an announcement.)
-
+
 These requirements apply to the modified work as a whole.  If
 identifiable sections of that work are not derived from the Program,
 and can be reasonably considered independent and separate works in
@@ -168,7 +168,7 @@ access to copy from a designated place, then offering equivalent
 access to copy the source code from the same place counts as
 distribution of the source code, even though third parties are not
 compelled to copy the source along with the object code.
-
+
   4. You may not copy, modify, sublicense, or distribute the Program
 except as expressly provided under this License.  Any attempt
 otherwise to copy, modify, sublicense or distribute the Program is
@@ -225,7 +225,7 @@ impose that choice.
 
 This section is intended to make thoroughly clear what is believed to
 be a consequence of the rest of this License.
-
+
   8. If the distribution and/or use of the Program is restricted in
 certain countries either by patents or by copyrighted interfaces, the
 original copyright holder who places the Program under this License
@@ -255,7 +255,7 @@ make exceptions for this.  Our decision will be guided by the two goals
 of preserving the free status of all derivatives of our free software and
 of promoting the sharing and reuse of software generally.
 
-			    NO WARRANTY
+                            NO WARRANTY
 
   11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
 FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
@@ -277,9 +277,9 @@ YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
 PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGES.
 
-		     END OF TERMS AND CONDITIONS
-
-	Appendix: How to Apply These Terms to Your New Programs
+                     END OF TERMS AND CONDITIONS
+
+            How to Apply These Terms to Your New Programs
 
   If you develop a new program, and you want it to be of the greatest
 possible use to the public, the best way to achieve this is to make it
@@ -291,7 +291,7 @@ convey the exclusion of warranty; and each file should have at least
 the "copyright" line and a pointer to where the full notice is found.
 
     <one line to give the program's name and a brief idea of what it does.>
-    Copyright (C) 19yy  <name of author>
+    Copyright (C) <year>  <name of author>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -303,16 +303,16 @@ the "copyright" line and a pointer to where the full notice is found.
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    You should have received a copy of the GNU General Public License along
+    with this program; if not, write to the Free Software Foundation, Inc.,
+    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 Also add information on how to contact you by electronic and paper mail.
 
 If the program is interactive, make it output a short notice like this
 when it starts in an interactive mode:
 
-    Gnomovision version 69, Copyright (C) 19yy name of author
+    Gnomovision version 69, Copyright (C) year name of author
     Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
     This is free software, and you are welcome to redistribute it
     under certain conditions; type `show c' for details.
@@ -335,5 +335,5 @@ necessary.  Here is a sample; alter the names:
 This General Public License does not permit incorporating your program into
 proprietary programs.  If your program is a subroutine library, you may
 consider it more useful to permit linking proprietary applications with the
-library.  If this is what you want to do, use the GNU Library General
+library.  If this is what you want to do, use the GNU Lesser General
 Public License instead of this License.
diff --git a/Documentation/licenses/COPYING.LGPLv2.1 b/Documentation/licenses/COPYING.LGPLv2.1
index cf9b6b9..4362b49 100644
--- a/Documentation/licenses/COPYING.LGPLv2.1
+++ b/Documentation/licenses/COPYING.LGPLv2.1
@@ -1,9 +1,8 @@
-
                   GNU LESSER GENERAL PUBLIC LICENSE
                        Version 2.1, February 1999
 
  Copyright (C) 1991, 1999 Free Software Foundation, Inc.
-     59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -23,8 +22,7 @@ specially designated software packages--typically libraries--of the
 Free Software Foundation and other authors who decide to use it.  You
 can use it too, but we suggest you first think carefully about whether
 this license or the ordinary General Public License is the better
-strategy to use in any particular case, based on the explanations
-below.
+strategy to use in any particular case, based on the explanations below.
 
   When we speak of free software, we are referring to freedom of use,
 not price.  Our General Public Licenses are designed to make sure that
@@ -57,7 +55,7 @@ modified by someone else and passed on, the recipients should know
 that what they have is not the original version, so that the original
 author's reputation will not be affected by problems that might be
 introduced by others.
-^L
+
   Finally, software patents pose a constant threat to the existence of
 any free program.  We wish to make sure that a company cannot
 effectively restrict the users of a free program by obtaining a
@@ -89,9 +87,9 @@ libraries.  However, the Lesser license provides advantages in certain
 special circumstances.
 
   For example, on rare occasions, there may be a special need to
-encourage the widest possible use of a certain library, so that it
-becomes a de-facto standard.  To achieve this, non-free programs must
-be allowed to use the library.  A more frequent case is that a free
+encourage the widest possible use of a certain library, so that it becomes
+a de-facto standard.  To achieve this, non-free programs must be
+allowed to use the library.  A more frequent case is that a free
 library does the same job as widely used non-free libraries.  In this
 case, there is little to gain by limiting the free library to free
 software only, so we use the Lesser General Public License.
@@ -113,7 +111,7 @@ modification follow.  Pay close attention to the difference between a
 "work based on the library" and a "work that uses the library".  The
 former contains code derived from the library, whereas the latter must
 be combined with the library in order to run.
-^L
+
                   GNU LESSER GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
@@ -138,8 +136,8 @@ included without limitation in the term "modification".)
   "Source code" for a work means the preferred form of the work for
 making modifications to it.  For a library, complete source code means
 all the source code for all modules it contains, plus any associated
-interface definition files, plus the scripts used to control
-compilation and installation of the library.
+interface definition files, plus the scripts used to control compilation
+and installation of the library.
 
   Activities other than copying, distribution and modification are not
 covered by this License; they are outside its scope.  The act of
@@ -218,7 +216,7 @@ instead of to this License.  (If a newer version than version 2 of the
 ordinary GNU General Public License has appeared, then you can specify
 that version instead if you wish.)  Do not make any other change in
 these notices.
-^L
+
   Once this change is made in a given copy, it is irreversible for
 that copy, so the ordinary GNU General Public License applies to all
 subsequent copies and derivative works made from that copy.
@@ -269,7 +267,7 @@ Library will still fall under Section 6.)
 distribute the object code for the work under the terms of Section 6.
 Any executables containing that work also fall under Section 6,
 whether or not they are linked directly with the Library itself.
-^L
+
   6. As an exception to the Sections above, you may also combine or
 link a "work that uses the Library" with the Library to produce a
 work containing portions of the Library, and distribute that work
@@ -305,10 +303,10 @@ of these things:
     the user installs one, as long as the modified version is
     interface-compatible with the version that the work was made with.
 
-    c) Accompany the work with a written offer, valid for at least
-    three years, to give the same user the materials specified in
-    Subsection 6a, above, for a charge no more than the cost of
-    performing this distribution.
+    c) Accompany the work with a written offer, valid for at
+    least three years, to give the same user the materials
+    specified in Subsection 6a, above, for a charge no more
+    than the cost of performing this distribution.
 
     d) If distribution of the work is made by offering access to copy
     from a designated place, offer equivalent access to copy the above
@@ -331,7 +329,7 @@ restrictions of other proprietary libraries that do not normally
 accompany the operating system.  Such a contradiction means you cannot
 use both them and the Library together in an executable that you
 distribute.
-^L
+
   7. You may place library facilities that are a work based on the
 Library side-by-side in a single library together with other library
 facilities not covered by this License, and distribute such a combined
@@ -372,7 +370,7 @@ subject to these terms and conditions.  You may not impose any further
 restrictions on the recipients' exercise of the rights granted herein.
 You are not responsible for enforcing compliance by third parties with
 this License.
-^L
+
   11. If, as a consequence of a court judgment or allegation of patent
 infringement or for any other reason (not limited to patent issues),
 conditions are imposed on you (whether by court order, agreement or
@@ -386,10 +384,9 @@ all those who receive copies directly or indirectly through you, then
 the only way you could satisfy both it and this License would be to
 refrain entirely from distribution of the Library.
 
-If any portion of this section is held invalid or unenforceable under
-any particular circumstance, the balance of the section is intended to
-apply, and the section as a whole is intended to apply in other
-circumstances.
+If any portion of this section is held invalid or unenforceable under any
+particular circumstance, the balance of the section is intended to apply,
+and the section as a whole is intended to apply in other circumstances.
 
 It is not the purpose of this section to induce you to infringe any
 patents or other property right claims or to contest validity of any
@@ -407,11 +404,11 @@ be a consequence of the rest of this License.
 
   12. If the distribution and/or use of the Library is restricted in
 certain countries either by patents or by copyrighted interfaces, the
-original copyright holder who places the Library under this License
-may add an explicit geographical distribution limitation excluding those
-countries, so that distribution is permitted only in or among
-countries not thus excluded.  In such case, this License incorporates
-the limitation as if written in the body of this License.
+original copyright holder who places the Library under this License may add
+an explicit geographical distribution limitation excluding those countries,
+so that distribution is permitted only in or among countries not thus
+excluded.  In such case, this License incorporates the limitation as if
+written in the body of this License.
 
   13. The Free Software Foundation may publish revised and/or new
 versions of the Lesser General Public License from time to time.
@@ -425,7 +422,7 @@ conditions either of that version or of any later version published by
 the Free Software Foundation.  If the Library does not specify a
 license version number, you may choose any version ever published by
 the Free Software Foundation.
-^L
+
   14. If you wish to incorporate parts of the Library into other free
 programs whose distribution conditions are incompatible with these,
 write to the author to ask for permission.  For software which is
@@ -459,21 +456,19 @@ SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
 DAMAGES.
 
                      END OF TERMS AND CONDITIONS
-^L
+
            How to Apply These Terms to Your New Libraries
 
   If you develop a new library, and you want it to be of the greatest
 possible use to the public, we recommend making it free software that
 everyone can redistribute and change.  You can do so by permitting
-redistribution under these terms (or, alternatively, under the terms
-of the ordinary General Public License).
-
-  To apply these terms, attach the following notices to the library.
-It is safest to attach them to the start of each source file to most
-effectively convey the exclusion of warranty; and each file should
-have at least the "copyright" line and a pointer to where the full
-notice is found.
+redistribution under these terms (or, alternatively, under the terms of the
+ordinary General Public License).
 
+  To apply these terms, attach the following notices to the library.  It is
+safest to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least the
+"copyright" line and a pointer to where the full notice is found.
 
     <one line to give the library's name and a brief idea of what it does.>
     Copyright (C) <year>  <name of author>
@@ -490,21 +485,18 @@ notice is found.
 
     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 
 Also add information on how to contact you by electronic and paper mail.
 
-You should also get your employer (if you work as a programmer) or
-your school, if any, to sign a "copyright disclaimer" for the library,
-if necessary.  Here is a sample; alter the names:
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the library, if
+necessary.  Here is a sample; alter the names:
 
   Yoyodyne, Inc., hereby disclaims all copyright interest in the
-  library `Frob' (a library for tweaking knobs) written by James
-  Random Hacker.
+  library `Frob' (a library for tweaking knobs) written by James Random Hacker.
 
   <signature of Ty Coon>, 1 April 1990
   Ty Coon, President of Vice
 
 That's all there is to it!
-
-
diff --git a/disk-utils/elvtune.c b/disk-utils/elvtune.c
index 7d8fe7b..7c3caed 100644
--- a/disk-utils/elvtune.c
+++ b/disk-utils/elvtune.c
@@ -13,11 +13,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *  This file may be redistributed under the terms of the GNU General
- *  Public License, version 2.
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <fcntl.h>
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 0bbe048..eab44f3 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -14,9 +14,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  * 1999/12/03: Linus Torvalds (cramfs tester and unarchive program)
  * 2000/06/03: Daniel Quinlan (CRC and length checking program)
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 37895a3..a1e16ce 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -13,9 +13,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/fdisk/cfdisk.c b/fdisk/cfdisk.c
index ffc12f6..a128ed7 100644
--- a/fdisk/cfdisk.c
+++ b/fdisk/cfdisk.c
@@ -21,9 +21,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with cfdisk; if not, write to the Free Software Foundation,
- * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  * Created:	Fri Jan 28 22:46:58 1994, martin@cs.unc.edu
  * >2GB patches: Sat Feb 11 09:08:10 1995, faith@cs.unc.edu
diff --git a/getopt/getopt.c b/getopt/getopt.c
index 3a31052..51ff19e 100644
--- a/getopt/getopt.c
+++ b/getopt/getopt.c
@@ -12,9 +12,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /* 
diff --git a/lib/path.c b/lib/path.c
index 54b8942..ad17fef 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -16,9 +16,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <stdarg.h>
diff --git a/libblkid/src/blkid.h.in b/libblkid/src/blkid.h.in
index da861a3..8f6d336 100644
--- a/libblkid/src/blkid.h.in
+++ b/libblkid/src/blkid.h.in
@@ -17,7 +17,7 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #ifndef _BLKID_BLKID_H
diff --git a/libblkid/src/partitions/blkid_parttypes.h b/libblkid/src/partitions/blkid_parttypes.h
index 707e53d..b0aad86 100644
--- a/libblkid/src/partitions/blkid_parttypes.h
+++ b/libblkid/src/partitions/blkid_parttypes.h
@@ -13,7 +13,7 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /* Note, _L32M means <32M (less), for example FAT16_L32M */
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index c407b98..2af7484 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -13,9 +13,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef _LIBMOUNT_MOUNT_H
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 9acc6e2..91afaae 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -14,9 +14,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 8468b3f..f33696a 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -15,9 +15,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <stdio.h>
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 92f4101..8a6062f 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -14,9 +14,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/mount/mount.8 b/mount/mount.8
index 2b01d93..b814f5e 100644
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -22,10 +22,9 @@
 .\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 .\" GNU General Public License for more details.
 .\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
-.\" USA.
+.\" You should have received a copy of the GNU General Public License along
+.\" with this program; if not, write to the Free Software Foundation, Inc.,
+.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
 .\" 960705, aeb: version for mount-2.7g
 .\" 970114, aeb: xiafs and ext are dead; romfs is new
diff --git a/mount/umount.8 b/mount/umount.8
index 934fb00..1c7d59a 100644
--- a/mount/umount.8
+++ b/mount/umount.8
@@ -18,10 +18,9 @@
 .\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 .\" GNU General Public License for more details.
 .\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
-.\" USA.
+.\" You should have received a copy of the GNU General Public License along
+.\" with this program; if not, write to the Free Software Foundation, Inc.,
+.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
 .TH UMOUNT 8 "March 2010" "util-linux" "System Administration"
 .SH NAME
diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index eb3e90b..b85717b 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -17,10 +17,9 @@
 .\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 .\" GNU General Public License for more details.
 .\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
-.\" USA.
+.\" You should have received a copy of the GNU General Public License along
+.\" with this program; if not, write to the Free Software Foundation, Inc.,
+.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
 .\" 2002-05-11 Robert Love <rml@tech9.net>
 .\" 	Initial version
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index b1c9108..944cd77 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -15,9 +15,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  * Copyright (C) 2004 Robert Love
  */
diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index 8917c66..efaa0d2 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -17,10 +17,9 @@
 .\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 .\" GNU General Public License for more details.
 .\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
-.\" USA.
+.\" You should have received a copy of the GNU General Public License along
+.\" with this program; if not, write to the Free Software Foundation, Inc.,
+.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
 .\" 2002-05-11 Robert Love <rml@tech9.net>
 .\" 	Initial version
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index fd8e29a..b7aee50 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -11,9 +11,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  *
  * Copyright (C) 2004 Robert Love
  * Copyright (C) 2010 Karel Zak <kzak@redhat.com>
diff --git a/sys-utils/arch.c b/sys-utils/arch.c
index 0892c96..0c29c3e 100644
--- a/sys-utils/arch.c
+++ b/sys-utils/arch.c
@@ -15,7 +15,8 @@
  *
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.  */
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
 
 #include <err.h>
 #include <errno.h>
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index 79f5167..58e40f9 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -14,9 +14,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <ctype.h>
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index ef19a77..80bb0ea 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -17,9 +17,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index f4bee83..3b3ebb9 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -14,9 +14,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <errno.h>
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 65e1eb6..3cdd767 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -14,9 +14,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <ctype.h>
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 78e7a41..f1cff74 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -23,10 +23,9 @@
 .\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 .\" GNU General Public License for more details.
 .\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
-.\" USA.
+.\" You should have received a copy of the GNU General Public License along
+.\" with this program; if not, write to the Free Software Foundation, Inc.,
+.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 .\"
 .\"
 .TH MOUNT 8 "January 2012" "util-linux" "System Administration"
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 15510e0..17991b0 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -14,9 +14,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <stdio.h>
diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 5cc833d..b3f150c 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -18,9 +18,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <stdio.h>
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 8235eb1..a446187 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -13,9 +13,9 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <errno.h>
diff --git a/sys-utils/readprofile.c b/sys-utils/readprofile.c
index 704201f..52e64e8 100644
--- a/sys-utils/readprofile.c
+++ b/sys-utils/readprofile.c
@@ -13,9 +13,9 @@
  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *   GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *   You should have received a copy of the GNU General Public License along
+ *   with this program; if not, write to the Free Software Foundation, Inc.,
+ *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index d94c654..cce4b53 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -14,9 +14,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <stdio.h>
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 13ee1e4..728b860 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -15,7 +15,7 @@
  *
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, write to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <errno.h>
-- 
1.7.9.1

