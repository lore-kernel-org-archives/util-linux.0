Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Wed, 4 Jan 2017 22:19:58 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: The Flying Rapist <impeccableenglish@gmail.com>, kerolasa@gmail.com,
        util-linux <util-linux@vger.kernel.org>,
        The Flying Rapist <admin@nosuck.org>
Subject: Re: [PATCH] col: backspacing widechars
In-Reply-To: <20170104110627.gwd2spbznfw4lssg@ws.net.home>
Message-ID: <alpine.LNX.2.20.1701042208001.5058@imuri>
References: <20161228093620.5528-1-ImpeccableEnglish@gmail.com> <CAG27Bk1eCMakhnbcmQZpYVvcYF2K+eYSekaQQFxUU5UPXfa2gA@mail.gmail.com> <20161228204237.GA29001@creation> <20170104110627.gwd2spbznfw4lssg@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Wed, 4 Jan 2017, Karel Zak wrote:

> On Wed, Dec 28, 2016 at 03:42:37PM -0500, The Flying Rapist wrote:
> > On 2016?12?28? 14?55?, Sami Kerola wrote:
> > > May I remind howto-contribute[1] tells 'using your real name (sorry,
> > > no pseudonyms
> > > or anonymous contributions.)'
> > 
> > I apologize.  I missed that part of howto-contribute.txt.  Please accept the following.
> > 
> > From: Grady Martin <admin@nosuck.org>
> 
> Thanks.
> 
> > 
> > Until now, backspace characters have not accounted for characters of widths other than one.  This single line amends that.
> > ---
> > text-utils/col.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/text-utils/col.c b/text-utils/col.c
> > index 9b0e23058..c63b46fee 100644
> > --- a/text-utils/col.c
> > +++ b/text-utils/col.c
> > @@ -248,7 +248,7 @@ int main(int argc, char **argv)
> >                        case BS:                /* can't go back further */
> >                                if (cur_col == 0)
> >                                        continue;
> > -                               --cur_col;
> > +                               cur_col -= c->c_width;
> >                                continue;
> 
> Where the c->c_width is initialized? It seems 'c' may be uninitialized
> or points for wrong char. What happen if I press BS more than once? Is
> 'c' initialized for the right char?  
> 
> I'm asking because I'm not sure, the code seems strange at the first
> glance.

Quite right.  The proposed change makes for example

printf " \v\b" | ./col

to crash.  How about change below? Updated version survived 1.5 million 
rounds of afl-fuzz without issues.

p.s. also available from
  git://github.com/kerolasa/lelux-utiliteetit.git col

--->8----
From: Grady Martin <admin@nosuck.org>
Date: Wed, 4 Jan 2017 22:01:40 +0000
Subject: [PATCH] col: backspacing widechars

Until now, backspace characters have not accounted for characters of widths
other than one.  This single line amends that.

Requsted-by: Grady Martin <admin@nosuck.org>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/col.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/text-utils/col.c b/text-utils/col.c
index 9b0e23058..7bf3708bd 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -160,7 +160,7 @@ static void __attribute__((__noreturn__)) wrerr(void)
 int main(int argc, char **argv)
 {
 	register wint_t ch;
-	CHAR *c;
+	CHAR *c = NULL;
 	CSET cur_set;			/* current character set */
 	LINE *l;			/* current line */
 	int extra_lines;		/* # of lines above first line */
@@ -248,7 +248,10 @@ int main(int argc, char **argv)
 			case BS:		/* can't go back further */
 				if (cur_col == 0)
 					continue;
-				--cur_col;
+				if (c)
+					cur_col -= c->c_width;
+				else
+					cur_col--;
 				continue;
 			case CR:
 				cur_col = 0;
@@ -369,7 +372,10 @@ int main(int argc, char **argv)
 		c = &l->l_line[l->l_line_len++];
 		c->c_char = ch;
 		c->c_set = cur_set;
-		c->c_column = cur_col;
+		if (0 < cur_col)
+			c->c_column = cur_col;
+		else
+			c->c_column = 0;
 		c->c_width = wcwidth(ch);
 		/*
 		 * If things are put in out of order, they will need sorting
-- 
2.11.0
