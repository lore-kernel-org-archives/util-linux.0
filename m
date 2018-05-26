Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sat, 26 May 2018 10:32:54 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] more: remove global variables, add struct
 more_control
In-Reply-To: <CAG27Bk2S4iLOSc0bADWfQKzEVTh+-mYAxbWSO+Y2bgswZKty5Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.20.1805261026360.8191@imuri>
References: <20180523222436.28823-1-kerolasa@iki.fi> <20180523222436.28823-2-kerolasa@iki.fi> <20180524071058.dgy5csrr6ucebwlo@ws.net.home> <CAG27Bk2S4iLOSc0bADWfQKzEVTh+-mYAxbWSO+Y2bgswZKty5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Thu, 24 May 2018, Sami Kerola wrote:

> On 24 May 2018 at 08:10, Karel Zak <kzak@redhat.com> wrote:
> > On Wed, May 23, 2018 at 11:24:36PM +0100, Sami Kerola wrote:
> >> -#define Fopen(s,m)   (Currline = 0,file_pos=0,fopen(s,m))
> >> -#define Ftell(f)     file_pos
> >> -#define Fseek(f,off) (file_pos=off,fseek(f,off,0))
> >> -#define Getc(f)              (++file_pos, getc(f))
> >> -#define Ungetc(c,f)  (--file_pos, ungetc(c,f))
> >> +#define Fopen(s,m)   (ctl->Currline = 0, ctl->file_pos=0, fopen(s,m))
> >> +#define Ftell(f)     ctl->file_pos
> >> +#define Fseek(f,off) (ctl->file_pos=off, fseek(f, off, 0))
> >> +#define Getc(f)              (++ctl->file_pos, getc(f))
> >> +#define Ungetc(c,f)  (--ctl->file_pos, ungetc(c,f))
> >
> > These macros are horrible. It would be nice to remove it by another
> > patch and use standard code rather than any macros -- for example
> > Fopen() is used only once.
> >
> > For often used stuff like Getc() it would be better to use inline functions.
> >
> > Anyway, modify 'ctl' (or any global variable) and don't use it as
> > argument for the macro is horrible.
> 
> My intention is to get rid of these macros completely. Precarious macros
> with pointer arguments will relatively soon. As it sounds you probably
> want that change to be added to this series. I'll do that during weekend.

Done in commit 7844bd1 that is available from my repo.

The 'more' branch also fixes BSB, BS, and CARAT definitions, and control 
structure uint32_t to unsigned int, see commit c02140b.

https://github.com/kerolasa/util-linux/commits/more

----------------------------------------------------------------
The following changes since commit 3abbd0814cf479f709a2da5822a215db69c5a6d0:
  libblkid: (ntfs) fix cluster size check (2018-05-25 21:02:23 +0200)
are available in the Git repository at:
  git://github.com/kerolasa/util-linux.git more 
for you to fetch changes up to 7844bd13df52dcf7afd44f43b1daa8ae506ddb11:
  more: remove function like preprocessor defines (2018-05-26 10:21:00 +0100)
----------------------------------------------------------------
Sami Kerola (3):
      more: move couple functions
      more: remove global variables, add struct more_control
      more: remove function like preprocessor defines

 text-utils/more.c | 1674 ++++++++++++++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 868 insertions(+), 806 deletions(-)
