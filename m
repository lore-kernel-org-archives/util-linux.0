Return-Path: util-linux-owner@vger.kernel.org
Received: from isilmar-3.linta.de ([188.40.101.200]:56547 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753678AbaJGVOd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Oct 2014 17:14:33 -0400
Date: Tue, 7 Oct 2014 23:07:19 +0200
From: Helmut Grohne <helmut@subdivi.de>
To: util-linux@vger.kernel.org
Cc: 764387@bugs.debian.org
Subject: [PATCH] autogen.sh: check for libtoolize rather than libtool
Message-ID: <20141007210718.GA746@alf.mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The system libtool program has architecture dependent behaviour. It is
therefore unavailable in cross build environments. The only place it was
used in util-linux is autogen.sh to determine the availability of
libtool. All other places correctly use libtoolize or
$(top_builddir)/libtool.

Signed-off-by: Helmut Grohne <helmut@subdivi.de>
---
 autogen.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This patch has been applied to Debian to ease cross compiling, because
there libtool will be unavailable soon.

Please CC me in replies.

Helmut

diff --git a/autogen.sh b/autogen.sh
index d1a686c..d0b340f 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -66,7 +66,7 @@ test -f sys-utils/mount.c || {
 	echo
 	DIE=1
 }
-(libtool --version) < /dev/null > /dev/null 2>&1 || {
+(libtoolize --version) < /dev/null > /dev/null 2>&1 || {
 	echo
 	echo "You must have libtool-2 installed to generate util-linux build system."
 	echo
-- 
2.1.0
