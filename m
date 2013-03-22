Return-Path: samuel.thibault@ens-lyon.org
Date: Fri, 22 Mar 2013 14:41:47 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.23-rc1
Message-ID: <20130322134147.GA6125@type.bordeaux.inria.fr>
References: <20130322125621.GA6278@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
In-Reply-To: <20130322125621.GA6278@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Karel Zak, le Fri 22 Mar 2013 13:56:21 +0100, a écrit :
> The util-linux release v2.23-rc1 is available at
>  
>    ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.23
>     
> Feedback and bug reports, as always, are welcomed.

Here is a couple of obvious fixes for non-linux systems.

Samuel

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index db5f41e..621df1e 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -118,7 +118,9 @@ static void tcinit(struct console *con)
 		cfsetispeed(tio, ispeed);
 		cfsetospeed(tio, ospeed);
 
+#ifdef HAVE_STRUCT_TERMIOS_C_LINE
 		tio->c_line         = 0;
+#endif
 		tio->c_cc[VTIME]    = 0;
 		tio->c_cc[VMIN]     = 1;
 
@@ -198,7 +200,7 @@ static void tcfinal(struct console *con)
 	tio->c_cc[VEOF]     = CEOF;
 #ifdef VSWTC
 	tio->c_cc[VSWTC]    = _POSIX_VDISABLE;
-#else
+#elif defined(VSWTCH)
 	tio->c_cc[VSWTCH]   = _POSIX_VDISABLE;
 #endif
 	tio->c_cc[VSTART]   = CSTART;

--ibTvN161/egqYuK8--
