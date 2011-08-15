Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110815141948.GH2038@nb.net.home>
References: <20110815141948.GH2038@nb.net.home>
Date: Mon, 15 Aug 2011 21:12:16 +0200
Message-ID: <CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
Subject: Re: man-pages and usage() howto
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 15, 2011 at 16:19, Karel Zak <kzak@redhat.com> wrote:
> Sami is already working on some howtos, what we need is some
> consensus about a way how describe options.

What I wrote about various things can be found from github. I'd say
that so far the Documentation directory patch set is a proposal, which
can and should change.

https://github.com/kerolasa/lelux-utiliteetit/blob/docs-dir/Documentation/h=
owto-usage-function.txt

> My suggestion:
>
> =A0* argument required:
>
> =A0 -o, --option FILE =A0 =A0# usage()
> =A0 -o, --option file =A0 =A0# man page

I used GNU notation which has 'unnecessary' equals sign.

-o, --option=3DFILE

The only reason I can think of why the equal sign is there is visual
similarity with optional argument...

> =A0* optional argument:
>
> =A0 -o, --option[=3DFILE] =A0# usage()
> =A0 -o, --option[=3Dfile] =A0# man page

...because with optional arguments one must use =3D and that make the
[=3DFILE] notation correct. For example see the output of the following.

lscpu -p=3DCPU
lscpu -p CPU

I also acknowledge the fact that no-one will ever use equals sign when
giving required argument. The practise of dropping it is a rational
reason not to specify it to usage() or man. I would say this is a
question of choosing a convention in between visual symmetry or actual
habits of people. IMHO the visual unity is better.

> =A0* synopsis
>
> =A0 - without individual options, bad example:
>
> =A0 =A0 =A0 =A0command [-o offset] [--sizelimit size] [-p pfd] [-r] file
>
> =A0 - [options] is better:
>
> =A0 =A0 =A0 =A0command [options] file

I agree.

> =A0 - use more synopsis lines if the command supports more separated mode=
s.
>
> =A0 =A0 =A0 command --add file
> =A0 =A0 =A0 command --del file
>
> =A0 =A0 (use common sense! ... if there is too many modes, then use [opti=
ons])
>
> =A0 =A0 The options specific to the mode are allowed in the synopsis or
> =A0 =A0 in the man page should be per-mode section with description about
> =A0 =A0 the options.

I did not think multiple modes when I  wrote howto-usage. Manual page
of man seems to be good example of extensive synopsis. If I've not
gone crazy the point of modes seems to point out that some options,
arguments, etc mean outcome of an execution is fundamentally
different, for example

man -k basename
man -w basename

So the howto should tell how do you know you are dealing with
fundamental difference of outcome, which requires multiple synopsis
lines. Obvious trap seems to be such hermeneutic circle that no-one
understands what the howto tries to say. Rigour rejection until the
text is good is needed.

> =A0* common options:
>
> =A0 -V, --version
> =A0 -h, --help

I would call these two options explicitly reserved. The `-?' should
not be a synonym of `-h' but an invalid option in common case.

> =A0* suggestions:
>
> =A0 -a, --all
> =A0 -o, --output <list>
> =A0 -r, --raw
> =A0 -f, --force
> =A0 -b, --bytes =A0 (don't print SIZE in human readable format)

Eric S. Raymond's The Art of Unix Programming is proposing something simila=
r.

http://www.faqs.org/docs/artu/ch10s05.html

In nutshell one should think carefully before using a short option
against it's well known other use.

I can think immediately an annoyance in the rule of well known. Well
known to who, in what context and is it even relevant? Could good go
around for this problem is to give a concrete list of short & long
options which in context of this package are well-known, and nothing
else is. That will also allow several well known definitions to a
single short option, which I like. For example

-s, --size
-s, --silent  (prefer -q)
-q, --quiet

Assuming this approach sounds good the question is shall we write
shortest or longest possible list of well known options list? I'm in
favour of short list because it requires less maintenance.

> =A0* We also need any consensus about groff formatting, the ideal
> =A0 solution would be add any Documentation/example.man

Here's my proposal, which without doubt needs honing.

https://github.com/kerolasa/lelux-utiliteetit/blob/docs-dir/Documentation/h=
owto-man-page.txt

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
