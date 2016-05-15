Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sun, 15 May 2016 18:03:24 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/12] write: improve coding style
In-Reply-To: <20160511085420.y6menmghp6qydbac@ws.net.home>
Message-ID: <alpine.LNX.2.20.1605151800570.592@imuri>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi> <1462829248-6935-12-git-send-email-kerolasa@iki.fi> <20160511085420.y6menmghp6qydbac@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Wed, 11 May 2016, Karel Zak wrote:

> You do not need the crazy macro at all
> 
>    while (*s) {
>         int rc = 0;
>         int c = *s++;
> 
>         if (c == '\n')
>             rc = fputc_careful('\n', stdout, '^');
>         if (rc == 0)
>             rc = fputc_careful(c, stdout, '^');
>         if (rc == EOF)
>             err(EXIT_FAILURE, _("carefulputc failed"));
>    }

The commit is amended in spirit of 'no macro at all'. The code is not 
exactly the same as above.

https://github.com/kerolasa/lelux-utiliteetit/commit/cbae2781ab82cd641ef1839f9fec71fe984322ff

-- snip
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 14 May 2016 16:40:45 +0100
Subject: [PATCH 11/15] write: remove PUTC macro

Function like macros make following the execution flow unnecessarily
difficult, and deserves to be removed.

Requested-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 57b2254..3b86694 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -220,18 +220,17 @@ static void signal_handler(int signo)
  */
 static void write_line(char *s)
 {
-	char c;
-
-#define	PUTC(c)	if (fputc_careful(c, stdout, '^') == EOF) \
-    err(EXIT_FAILURE, _("carefulputc failed"));
 	while (*s) {
-		c = *s++;
-		if (c == '\n')
-			PUTC('\r');
-		PUTC(c);
+		const int c = *s++;
+
+		if (c == '\n') {
+			if (fputc_careful('\r', stdout, '^') == EOF)
+				goto fail;
+		}
+		if (fputc_careful(c, stdout, '^') == EOF)
+ fail:
+			err(EXIT_FAILURE, _("carefulputc failed"));
 	}
-	return;
-#undef PUTC
 }
 
 /*
-- 
2.8.2
-- snip

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
