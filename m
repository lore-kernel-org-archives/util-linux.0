Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853121FF39
	for <util-linux@vger.kernel.org>; Mon,  2 Jun 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873724; cv=none; b=fkwILbAgHeDsd2I94/lghLxWfSAbOJLNdIUzgbOK85iIbKkjEvPtezHavThkkNWJBEFbydGZZosOLeo49ouLuz0wx31RIP0hdu2r9bgbd/oZo9+hIyuz59kDJPaFvB+2KFZTocGv/J5kJ0b+0Vu3LOFKN0HvcsgAydIP9C4Dxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873724; c=relaxed/simple;
	bh=zwIGLXMP7t9X/s5UxPFqFKIw+B1+HtNzv0xJAIu1As0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyEECRn9Fo/SdSDSwSmdW7r5UMn9kliB1EYJVzxx2Kqfu8JwMJvZtJeI4KJep3LLOrGw0M2fbvvboeK4rm5qa4PCz/Z30rdoGVhLV2qmlXv7a/SgxCo0llNKl0pAGZM68wCM5AkohIDZJ0T6AyMBUDl+21lFMqATn8jlcfUGC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=VBSJ6qQ2; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="VBSJ6qQ2"
X-KPN-MessageId: 23c4e81b-3fbc-11f0-a830-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 23c4e81b-3fbc-11f0-a830-005056abad63;
	Mon, 02 Jun 2025 16:16:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=0qwkKqUTgXawzYyvKXhCDMplYRlLS/FOWu6d/x0p6Bo=;
	b=VBSJ6qQ2p2g7Q6snNKQNSoX11WnLul+tT6Sv7vyQyuHQw/lsR4F/z8k5IWqyjFndSMaDk/Ak5x4Jo
	 xuQUdH6cVPyzv2GZleyX1NRb9tm93i3P7S0Kqdg2H73bAYBYplbFDtYFIHoffLHbZ8daLXBKUCekx6
	 Q0dS6LLVqq8BjmPo=
X-KPN-MID: 33|cZYypzprZsL6N+8WS8KGyuSxXTlaFfBM6ypxTyzUVgh+tOoIwyQh6PnbvS7J5BI
 kXF6A+Y/hFx8dYRN66rLWwA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|x/YZEBs7tF9ig2iLv73XdMxnt/1B2CzAp+LmNz11hegcVoYiVLEY1O9pJRTOvYU
 NFzXu8cTdn597mHdIQ/tsew==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0358323e-3fbc-11f0-859e-005056ab7584;
	Mon, 02 Jun 2025 16:15:19 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/6] treewide: replace postal address in license specifier with a terse URL
Date: Mon,  2 Jun 2025 16:14:36 +0200
Message-ID: <20250602141436.11156-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250602141436.11156-1-bensberg@telfort.nl>
References: <20250602141436.11156-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This brings the license specifier into the internet age.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/fsck.cramfs.c         | 5 ++---
 disk-utils/mkfs.cramfs.c         | 5 ++---
 include/caputils.h               | 5 ++---
 include/plymouth-ctrl.h          | 4 +---
 lib/caputils.c                   | 5 ++---
 lib/exec_shell.c                 | 5 ++---
 lib/plymouth-ctrl.c              | 4 +---
 libblkid/src/blkid.h.in          | 5 ++---
 libfdisk/src/libfdisk.h.in       | 5 ++---
 libmount/python/context.c        | 5 ++---
 libmount/python/fs.c             | 5 ++---
 libmount/python/pylibmount.c     | 5 ++---
 libmount/python/tab.c            | 5 ++---
 libmount/src/libmount.h.in       | 5 ++---
 login-utils/last.1.adoc          | 3 +--
 login-utils/last.c               | 3 +--
 login-utils/lslogins.c           | 5 ++---
 login-utils/su-common.c          | 8 ++++----
 login-utils/sulogin-consoles.c   | 4 +---
 login-utils/sulogin-consoles.h   | 4 +---
 login-utils/sulogin.8.adoc       | 3 +--
 login-utils/sulogin.c            | 3 +--
 login-utils/utmpdump.1.adoc      | 3 +--
 login-utils/utmpdump.c           | 3 +--
 misc-utils/enosys.c              | 5 ++---
 misc-utils/fadvise.c             | 5 ++---
 misc-utils/fincore.c             | 5 ++---
 misc-utils/findmnt.c             | 5 ++---
 misc-utils/getopt.c              | 5 ++---
 misc-utils/lsblk.c               | 5 ++---
 misc-utils/lsclocks.c            | 5 ++---
 misc-utils/pipesz.c              | 5 ++---
 misc-utils/waitpid.c             | 5 ++---
 misc-utils/wipefs.c              | 5 ++---
 schedutils/chrt.1.adoc           | 5 ++---
 schedutils/chrt.c                | 5 ++---
 schedutils/sched_attr.h          | 5 ++---
 schedutils/taskset.1.adoc        | 5 ++---
 schedutils/taskset.c             | 5 ++---
 schedutils/uclampset.1.adoc      | 5 ++---
 schedutils/uclampset.c           | 5 ++---
 sys-utils/chcpu.c                | 5 ++---
 sys-utils/chmem.c                | 5 ++---
 sys-utils/choom.c                | 5 ++---
 sys-utils/fallocate.c            | 5 ++---
 sys-utils/ipcmk.c                | 5 ++---
 sys-utils/lsipc.c                | 5 ++---
 sys-utils/mount.8.adoc           | 5 ++---
 sys-utils/setpriv.c              | 5 ++---
 sys-utils/umount.8.adoc          | 5 ++---
 sys-utils/umount.c               | 5 ++---
 sys-utils/unshare.c              | 5 ++---
 sys-utils/wdctl.c                | 5 ++---
 sys-utils/zramctl.c              | 5 ++---
 tests/helpers/test_enosys.c      | 5 ++---
 tests/helpers/test_mkfds.c       | 5 ++---
 tests/helpers/test_mkfds.h       | 5 ++---
 tests/helpers/test_mkfds_ppoll.c | 5 ++---
 58 files changed, 108 insertions(+), 169 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index b5d64c36a..8384bd5da 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -16,9 +16,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  * 1999/12/03: Linus Torvalds (cramfs tester and unarchive program)
  * 2000/06/03: Daniel Quinlan (CRC and length checking program)
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index c8130055d..64d3a3371 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -15,9 +15,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 /*
diff --git a/include/caputils.h b/include/caputils.h
index 8fc214e7f..0a966d96e 100644
--- a/include/caputils.h
+++ b/include/caputils.h
@@ -9,9 +9,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #ifndef CAPUTILS_H
diff --git a/include/plymouth-ctrl.h b/include/plymouth-ctrl.h
index b6f129956..98bf6f88f 100644
--- a/include/plymouth-ctrl.h
+++ b/include/plymouth-ctrl.h
@@ -15,9 +15,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (see the file COPYING); if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- * MA 02110-1301, USA.
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  * Author: Werner Fink <werner@suse.de>
  */
diff --git a/lib/caputils.c b/lib/caputils.c
index 23866c071..6c71c06b8 100644
--- a/lib/caputils.c
+++ b/lib/caputils.c
@@ -9,9 +9,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <sys/prctl.h>
diff --git a/lib/exec_shell.c b/lib/exec_shell.c
index 96d3e95a8..ffe65f006 100644
--- a/lib/exec_shell.c
+++ b/lib/exec_shell.c
@@ -11,9 +11,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <stdlib.h>
diff --git a/lib/plymouth-ctrl.c b/lib/plymouth-ctrl.c
index 2d3deda07..81f9c9f7d 100644
--- a/lib/plymouth-ctrl.c
+++ b/lib/plymouth-ctrl.c
@@ -18,9 +18,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (see the file COPYING); if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- * MA 02110-1301, USA.
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  * Author: Werner Fink <werner@suse.de>
  */
diff --git a/libblkid/src/blkid.h.in b/libblkid/src/blkid.h.in
index 91fc3b0be..db70d9e5a 100644
--- a/libblkid/src/blkid.h.in
+++ b/libblkid/src/blkid.h.in
@@ -15,9 +15,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #ifndef _BLKID_BLKID_H
diff --git a/libfdisk/src/libfdisk.h.in b/libfdisk/src/libfdisk.h.in
index be3b22e7a..7385755e4 100644
--- a/libfdisk/src/libfdisk.h.in
+++ b/libfdisk/src/libfdisk.h.in
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #ifndef _LIBFDISK_H
diff --git a/libmount/python/context.c b/libmount/python/context.c
index 36cf488f8..ca96ca5b8 100644
--- a/libmount/python/context.c
+++ b/libmount/python/context.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include "pylibmount.h"
 
diff --git a/libmount/python/fs.c b/libmount/python/fs.c
index a8e60eea7..cb48c43a1 100644
--- a/libmount/python/fs.c
+++ b/libmount/python/fs.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 /*
diff --git a/libmount/python/pylibmount.c b/libmount/python/pylibmount.c
index 03af1eeb0..e8c191602 100644
--- a/libmount/python/pylibmount.c
+++ b/libmount/python/pylibmount.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include "pylibmount.h"
 
diff --git a/libmount/python/tab.c b/libmount/python/tab.c
index 8401ee1b2..14a39da85 100644
--- a/libmount/python/tab.c
+++ b/libmount/python/tab.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include "pylibmount.h"
 
diff --git a/libmount/src/libmount.h.in b/libmount/src/libmount.h.in
index 33c6381c8..9d173ff0e 100644
--- a/libmount/src/libmount.h.in
+++ b/libmount/src/libmount.h.in
@@ -16,9 +16,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #ifndef _LIBMOUNT_MOUNT_H
diff --git a/login-utils/last.1.adoc b/login-utils/last.1.adoc
index f3ee91c54..76079222f 100644
--- a/login-utils/last.1.adoc
+++ b/login-utils/last.1.adoc
@@ -13,8 +13,7 @@ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
-along with this program; if not, write to the Free Software
-Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+along with this program.  If not, see <https://gnu.org/licenses/>.
 ////
 ifdef::neverdefined[---]
 
diff --git a/login-utils/last.c b/login-utils/last.c
index 0f202ceaf..85e3dfaeb 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -21,8 +21,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index b7f10667e..678f75c4c 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <stdio.h>
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 4f2856e60..2cdeba857 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -13,10 +13,10 @@
  * This program is distributed in the hope that it will be useful, but WITHOUT
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.  You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
- * USA.
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  *
  * Based on an implementation by David MacKenzie <djm@gnu.ai.mit.edu>.
diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 0dca949f4..cb9eb02bb 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -16,9 +16,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (see the file COPYING); if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- * MA 02110-1301, USA.
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  * Author: Werner Fink <werner@suse.de>
  */
diff --git a/login-utils/sulogin-consoles.h b/login-utils/sulogin-consoles.h
index 608c4f84f..d3b4298e4 100644
--- a/login-utils/sulogin-consoles.h
+++ b/login-utils/sulogin-consoles.h
@@ -15,9 +15,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program (see the file COPYING); if not, write to the
- * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- * MA 02110-1301, USA.
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  * Author: Werner Fink <werner@suse.de>
  */
diff --git a/login-utils/sulogin.8.adoc b/login-utils/sulogin.8.adoc
index db61ed4fb..52b749dc0 100644
--- a/login-utils/sulogin.8.adoc
+++ b/login-utils/sulogin.8.adoc
@@ -14,8 +14,7 @@ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
-along with this program; if not, write to the Free Software
-Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+along with this program.  If not, see <https://gnu.org/licenses/>.
 ////
 ifdef::neverdefined[---]
 
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index cfc642070..0de850508 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -21,8 +21,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <sys/mman.h>
 #include <sys/types.h>
diff --git a/login-utils/utmpdump.1.adoc b/login-utils/utmpdump.1.adoc
index 8dd21f09c..35468b6f7 100644
--- a/login-utils/utmpdump.1.adoc
+++ b/login-utils/utmpdump.1.adoc
@@ -13,8 +13,7 @@ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
-along with this program; if not, write to the Free Software
-Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+along with this program.  If not, see <https://gnu.org/licenses/>.
 ////
 ifdef::neverdefined[---]
 
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index ce9ad718b..65de1628e 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -22,8 +22,7 @@
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/misc-utils/enosys.c b/misc-utils/enosys.c
index 2d3d833d4..68e426c9d 100644
--- a/misc-utils/enosys.c
+++ b/misc-utils/enosys.c
@@ -11,9 +11,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <stddef.h>
diff --git a/misc-utils/fadvise.c b/misc-utils/fadvise.c
index 0b8cbb05c..abbc3a62d 100644
--- a/misc-utils/fadvise.c
+++ b/misc-utils/fadvise.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <fcntl.h>
diff --git a/misc-utils/fincore.c b/misc-utils/fincore.c
index 2f878abb6..c297c1045 100644
--- a/misc-utils/fincore.c
+++ b/misc-utils/fincore.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <sys/mman.h>
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 1211bfa07..ee9371e69 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index ae35baaf8..70a7edf89 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -12,9 +12,8 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 /*
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index da44bd631..af6ab0450 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -15,9 +15,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <stdio.h>
 #include <errno.h>
diff --git a/misc-utils/lsclocks.c b/misc-utils/lsclocks.c
index 42a91fb94..24761bbd3 100644
--- a/misc-utils/lsclocks.c
+++ b/misc-utils/lsclocks.c
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <stdio.h>
diff --git a/misc-utils/pipesz.c b/misc-utils/pipesz.c
index 6eb5cc001..0d1a2fc92 100644
--- a/misc-utils/pipesz.c
+++ b/misc-utils/pipesz.c
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <getopt.h>
diff --git a/misc-utils/waitpid.c b/misc-utils/waitpid.c
index 379246b26..f108206a9 100644
--- a/misc-utils/waitpid.c
+++ b/misc-utils/waitpid.c
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <sys/epoll.h>
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 04d8ae8c2..a215088a4 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 3d3948050..77add535d 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -19,9 +19,8 @@ but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
-You should have received a copy of the GNU General Public License along
-with this program; if not, write to the Free Software Foundation, Inc.,
-51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+You should have received a copy of the GNU General Public License
+along with this program.  If not, see <https://gnu.org/licenses/>.
 ////
 ifdef::neverdefined[---]
 
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 075b592bb..cf99935dc 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  * Copyright (C) 2004 Robert Love
  */
diff --git a/schedutils/sched_attr.h b/schedutils/sched_attr.h
index e597bced8..4d437046b 100644
--- a/schedutils/sched_attr.h
+++ b/schedutils/sched_attr.h
@@ -8,9 +8,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  * Copyright (C) 2004 Robert Love
  * Copyright (C) 2020-2021 Qais Yousef
diff --git a/schedutils/taskset.1.adoc b/schedutils/taskset.1.adoc
index 8c4d84dcc..9773303f7 100644
--- a/schedutils/taskset.1.adoc
+++ b/schedutils/taskset.1.adoc
@@ -17,9 +17,8 @@ but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
-You should have received a copy of the GNU General Public License along
-with this program; if not, write to the Free Software Foundation, Inc.,
-51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+You should have received a copy of the GNU General Public License
+along with this program.  If not, see <https://gnu.org/licenses/>.
 ////
 ifdef::neverdefined[---]
 
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index dedcdf602..b52cd4338 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -10,9 +10,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  * Copyright (C) 2004 Robert Love
  * Copyright (C) 2010 Karel Zak <kzak@redhat.com>
diff --git a/schedutils/uclampset.1.adoc b/schedutils/uclampset.1.adoc
index fb48b2bf8..001793b06 100644
--- a/schedutils/uclampset.1.adoc
+++ b/schedutils/uclampset.1.adoc
@@ -19,9 +19,8 @@ but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
-You should have received a copy of the GNU General Public License along
-with this program; if not, write to the Free Software Foundation, Inc.,
-51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+You should have received a copy of the GNU General Public License
+along with this program.  If not, see <https://gnu.org/licenses/>.
 ////
 ifdef::neverdefined[---]
 
diff --git a/schedutils/uclampset.c b/schedutils/uclampset.c
index b1ae32b3d..7b7e3f22b 100644
--- a/schedutils/uclampset.c
+++ b/schedutils/uclampset.c
@@ -10,9 +10,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  * Copyright (C) 2020-2021 Qais Yousef
  * Copyright (C) 2020-2021 Arm Ltd
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index ab765a67e..4a2ce66ff 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <ctype.h>
diff --git a/sys-utils/chmem.c b/sys-utils/chmem.c
index 17d782f25..932d0af13 100644
--- a/sys-utils/chmem.c
+++ b/sys-utils/chmem.c
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <stdio.h>
 #include <unistd.h>
diff --git a/sys-utils/choom.c b/sys-utils/choom.c
index 673b6f7e2..e818ab41d 100644
--- a/sys-utils/choom.c
+++ b/sys-utils/choom.c
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index fff75b03f..7b65481cc 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -17,9 +17,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index 5fa5869c6..cccb92c70 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -17,9 +17,8 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index a89ed4c5c..f0e81dbfd 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -17,9 +17,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  *
  * lsipc is inspired by the ipcs utility. The aim is to create
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 0e431004b..061e20aaa 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -25,9 +25,8 @@ but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
-You should have received a copy of the GNU General Public License along
-with this program; if not, write to the Free Software Foundation, Inc.,
-51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+You should have received a copy of the GNU General Public License
+along with this program.  If not, see <https://gnu.org/licenses/>.
 ////
 ifdef::neverdefined[---]
 
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index d714650e8..c6ff7718e 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <cap-ng.h>
diff --git a/sys-utils/umount.8.adoc b/sys-utils/umount.8.adoc
index 4f45dec7f..b91014cc7 100644
--- a/sys-utils/umount.8.adoc
+++ b/sys-utils/umount.8.adoc
@@ -20,9 +20,8 @@ but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
-You should have received a copy of the GNU General Public License along
-with this program; if not, write to the Free Software Foundation, Inc.,
-51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+You should have received a copy of the GNU General Public License
+along with this program.  If not, see <https://gnu.org/licenses/>.
 ////
 ifdef::neverdefined[---]
 
diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index d8ab3f7ca..c115f44a0 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <stdio.h>
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index fe140a0c7..e7c8c0f26 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 6559b5441..9290eb312 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -14,9 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 #include <sys/ioctl.h>
 #include <getopt.h>
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index fdb173ea5..175ad98d5 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -13,9 +13,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <getopt.h>
diff --git a/tests/helpers/test_enosys.c b/tests/helpers/test_enosys.c
index 98f8d15ee..c6d1f7f60 100644
--- a/tests/helpers/test_enosys.c
+++ b/tests/helpers/test_enosys.c
@@ -11,9 +11,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include <err.h>
diff --git a/tests/helpers/test_mkfds.c b/tests/helpers/test_mkfds.c
index f7673c865..57f99e5a3 100644
--- a/tests/helpers/test_mkfds.c
+++ b/tests/helpers/test_mkfds.c
@@ -12,9 +12,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #include "c.h"
diff --git a/tests/helpers/test_mkfds.h b/tests/helpers/test_mkfds.h
index 7d679b44f..1002ee19d 100644
--- a/tests/helpers/test_mkfds.h
+++ b/tests/helpers/test_mkfds.h
@@ -12,9 +12,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  */
 
 #ifndef TEST_MKFDS_H
diff --git a/tests/helpers/test_mkfds_ppoll.c b/tests/helpers/test_mkfds_ppoll.c
index fd1022616..2cd367b44 100644
--- a/tests/helpers/test_mkfds_ppoll.c
+++ b/tests/helpers/test_mkfds_ppoll.c
@@ -12,9 +12,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://gnu.org/licenses/>.
  *
  */
 
-- 
2.48.1

