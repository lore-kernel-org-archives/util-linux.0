Return-Path: heiko.carstens@de.ibm.com
Date: Fri, 16 Sep 2011 10:28:43 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/6] chcpu: convert to use lib/path.c
Message-ID: <20110916082843.GA12600@osiris.boeblingen.de.ibm.com>
References: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
 <1316069554-20977-3-git-send-email-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316069554-20977-3-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

>  int
> +path_writestr(const char *str, const char *path, ...)
> +{
> +	int fd, result;
> +	va_list ap;
> +
> +	va_start(ap, path);
> +	fd = path_vopen(O_WRONLY, path, ap);
> +	va_end(ap);
> +	result = write(fd, str, strlen(str));
> +	close(fd);
> +	return result;
> +}

Hmm, this is not ok. The patch below is needed on top. Sorry...


Subject: [PATCH] lib,path: use write_all()

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Since write() doesn't necessarily write the complete buffer with
one call we better use write_all() which takes care of this.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/path.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/path.c b/lib/path.c
index e2bb398..54b8942 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -27,6 +27,7 @@
 #include <stdio.h>
 #include <errno.h>
 
+#include "writeall.h"
 #include "cpuset.h"
 #include "path.h"
 #include "nls.h"
@@ -132,7 +133,7 @@ path_writestr(const char *str, const char *path, ...)
 	va_start(ap, path);
 	fd = path_vopen(O_WRONLY, path, ap);
 	va_end(ap);
-	result = write(fd, str, strlen(str));
+	result = write_all(fd, str, strlen(str));
 	close(fd);
 	return result;
 }
-- 
1.7.5.4
