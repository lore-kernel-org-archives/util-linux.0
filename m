Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110718221751.GD4354@nb.redhat.com>
References: <CAG27Bk0XXawQERH19+iUguDame2Pts_+bvrt8Of0+ib9KSW3NA@mail.gmail.com>
	<20110718221751.GD4354@nb.redhat.com>
Date: Wed, 20 Jul 2011 10:15:13 +0200
Message-ID: <CAG27Bk3vs54m7b6y_M_uq4RuyPBn-yhAEt2GhicsyY8F_+jJfw@mail.gmail.com>
Subject: Re: [git pull] schedutils
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 19, 2011 at 00:17, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Jul 17, 2011 at 08:37:58PM +0200, Sami Kerola wrote:
>> =A0 =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 printf(_("unknown\n"));
>> + =A0 =A0 =A0 =A0 =A0 =A0 printf(_("unknown scheduling policy\n"));
>
> =A0what about warnx() ?

You are right. Change is done.

>> + =A0 =A0 printf(_("policy =A0 =A0 =A0 =A0 =A0: min/max priority\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"----------------+-----------------\n"));
>
> =A0oh...
>
>> =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(policies); i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int max =3D sched_get_priority_max(policies[=
i]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int min =3D sched_get_priority_min(policies[=
i]);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max >=3D 0 && min >=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(_("SCHED_%s min/max pri=
ority\t: %d/%d\n"),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(_("SCHED_%-10s: %d/%d\n=
"),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 names[i], min, max);
>
> =A0...this is not backwardly compatible.
>
> =A0If you really want to have nice output then use include/tt.c (see for
> =A0example partx, findmnt or lsblk) and add a new option for such
> =A0functionality.

This change is dropped for now.

>> =A0.SH SYNOPSIS
>> =A0.B ionice
>> -.RB [[ \-c
>> -.IR class ]
>> -.RB [ \-n
>> -.IR classdata ]
>> -.RB [ \-t ]]
>> -.BI \-p \ PID
>> -.RI [ PID =A0]...
>> +[OPTION] \fB\-p\fR PID [PID...]
>> =A0.br
>> =A0.B ionice
>> -.RB [ \-c
>> -.IR class ]
>> -.RB [ \-n
>> -.IR classdata ]
>> -.RB [ \-t ]
>> -.IR COMMAND\ =A0[ ARG =A0]...
>> +[OPTION] COMMAND
>
> hmm.. don't forget that people love examples, IMHO the old version
> seems more readable.

I put the longer synopsis back in place.

>> =A0 =A0 =A0 textdomain(PACKAGE);
>>
>> - =A0 =A0 while ((c =3D getopt(argc, argv, "+n:c:p:th")) !=3D EOF) {
>> + =A0 =A0 while ((c =3D getopt_long(argc, argv, "+n:c:p:tVh", longopts, =
NULL)) !=3D EOF)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (c) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 'n':
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioprio =3D strtol_or_err(optar=
g, _("failed to parse class data"));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioprio =3D strtol_or_err(optar=
g, _("failed to parse priority"));
>
> well, the original kernel Documentation/block/ioprio.txt is talking
> about "class data" and I think it would be better to follow kernel
> here. Maybe one day the mask for the syscall will used for a different
> things than only for priority...

I read kernel documentation using priority, class data and level as
synonyms. To me the `class data' is most confusing because it gets
mixed up with `class'. As you did not like `priority' I do my last
attempt to change the word and used `level'. How that would sound?
IMHO it is a clarity enhancement, which should lead to greater
usability (that admittedly very difficult to measure).

>> + =A0 =A0 =A0 =A0 =A0 =A0 case 'V':
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(_("%s (%s)\n"),
>
> =A0"%s from %s" ;-)

Chanced to all of these three utilities.

The fixes are available in the git repository at:
 https://github.com/kerolasa/lelux-utiliteetit schedutils

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
