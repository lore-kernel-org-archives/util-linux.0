Return-Path: linux-fsdevel-owner@vger.kernel.org
Date: Tue, 29 Mar 2016 11:43:08 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.28-rc2
Message-ID: <20160329094308.GA3019@var.bordeaux.inria.fr>
References: <20160329091012.x3qea5ga2qzxqkrw@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160329091012.x3qea5ga2qzxqkrw@ws.net.home>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Karel Zak, on Tue 29 Mar 2016 11:10:12 +0200, wrote:
> The util-linux release v2.28-rc2 is available at
>  
>    http://ftp.kernel.org/pub/linux/utils/util-linux/v2.28
>     
> Feedback and bug reports, as always, are welcomed.

The Hurd provides a BSD-compatible interface (thus defines BSD to
something 1993-ish), but not compatible with more recent BSDs.
setprogname appeared around 2004 and such. The patch below just detects
the availability.

Samuel


diff --git a/configure.ac b/configure.ac
index 1519c97..9502d84 100644
--- a/configure.ac
+++ b/configure.ac
@@ -380,6 +380,7 @@ AC_CHECK_FUNCS([ \
 	qsort_r \
 	rpmatch \
 	scandirat \
+	setprogname \
 	setresgid \
 	setresuid \
 	sched_setattr \
diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index c4144f6..1efae07 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -453,7 +453,7 @@ int main(int argc, char *argv[])
 
 	if (name) {
 		argv[optind - 1] = name;
-#if defined (BSD) || defined (__APPLE__)
+#if (defined (BSD) || defined (__APPLE__)) && defined (HAVE_SETPROGNAME)
 		setprogname(name);
 #endif
 	} else
