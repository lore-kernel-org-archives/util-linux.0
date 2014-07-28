Return-Path: util-linux-owner@vger.kernel.org
Received: from mx5-phx2.redhat.com ([209.132.183.37]:60383 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaG1Oil (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 Jul 2014 10:38:41 -0400
Date: Mon, 28 Jul 2014 10:38:39 -0400 (EDT)
From: Jaromir Capik <jcapik@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Message-ID: <969740755.24655086.1406558319251.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAG27Bk1hbE+WE7+CeMPv03YYR-78jGm8cG-kQNufgLfAU6f3qQ@mail.gmail.com>
References: <844628876.22654954.1406302034993.JavaMail.zimbra@redhat.com> <2139170067.22662578.1406302189694.JavaMail.zimbra@redhat.com> <CAG27Bk1hbE+WE7+CeMPv03YYR-78jGm8cG-kQNufgLfAU6f3qQ@mail.gmail.com>
Subject: Re: [PATCH] fdformat: Add new switches -f/--from, -t/--to,
 -r/--repair
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


> Hi Jaromir,

Hi Sami.


> > It also fixes a recently introduced bug that causes
> > line breakage when printing the track number.
> 
> Do you mean commit 18b1fcb9cc62f4dd26eccd1c35f612ac6db1cd9b or some other
> change? 

Yes, exactly this commit.


> It would be nice to know details of what exactly was wrong, and
> how the fix is fixing it.

Ok ... so:
1.) The following hunk changes %3d to invalid %3ud and that caused
an extra character 'd' printed with each track change and as there
are only 3 backspaces, the whole string was slowly moving to the
right instead of staying at the same place. 

-		printf("%3d\b\b\b", track);
+		printf("%3ud\b\b\b", track);

Note, that 'u' is NOT a modifier, that needs to be prepended to 'd'.
The 'd' specifier needs to be replaced with 'u' instead.

2.) The following hunk changes %3d to invalid %u3d and that caused
extra characters '3d' appended to each track number.

-		printf("%3d\b\b\b", cyl);
+		printf("%u3d\b\b\b", cyl);

And after crossing the 10th track the final result was '103d'
where 3 backspace chars were unable to return to the first
characters and that produced something like:

111111111122222222223333333333444444473d

Note that '3' is a width modifier and always needs to be prepended
to the 'u' type specifier. So, the position matters:


>  The change you sent is rather long, and at
> least I cannot see where is the correction.  That said splitting the
> change to smaller chunks would be nice.

It has no sense to split that as I modified the code to support
heads and the format string had to be changed to a different one.


> > +static void format_begin(int ctrl)
> > +{
> > + if (ioctl(ctrl, FDFMTBEG, NULL) < 0)
> > + err(EXIT_FAILURE, "ioctl: FDFMTBEG");
> > +}
> > +
> > +static void format_end(int ctrl)
> > +{
> > + if (ioctl(ctrl, FDFMTEND, NULL) < 0)
> > + err(EXIT_FAILURE, "ioctl: FDFMTEND");
> > +}
> > +
> 
> The format_begin() and format_end() are not doing much, are they really
> needed?

They increase the code abstraction and readability.
There's a condition checking the return state and the code
is reused 3 times. Nobody can notice those wasted microseconds
when the whole format takes minutes. I really believe it is worthy.
We could possibly change them to inline functions, but it is really
not necessary in this case.


> > +static void format_track_head(int ctrl, unsigned int track, unsigned int
> > head)
> >  {
> >   struct format_descr descr;
> > - unsigned int track;
> > +
> > + descr.track = track;
> > + descr.head = head;
> > + if (ioctl(ctrl, FDFMTTRK, (long) &descr) < 0)
> > + err(EXIT_FAILURE, "ioctl: FDFMTTRK");
> > +}
> > +
> > +static void seek_track_head(int ctrl, unsigned int track, unsigned int
> > head)
> > +{
> > + lseek(ctrl, (track * param.head + head) * param.sect * SECTOR_SIZE,
> > SEEK_SET);
> > +}
> > +
> 
> Would it be possible to more  'struct floppy_struct param;' out of the
> global scope?  That would make it a bit less mysterious where param.head
> came from.

At first I tested exactly this variant, then I rewrote it to 2 separate
variables as (according to my opinion) the code looked better readable
and understandable. But I'm not against changing this as both variants
make sense for me.


> > +static void format_disk(int ctrl, unsigned int track_from, unsigned int
> > track_to)
> > +{
> > + unsigned int track, head;
> 
> The track & head could be replaced with
> 
> struct format_descr descr;
> 
> When the two helper variables are gone the format_track_head() turns to a
> single if (ioctl...  statement, and I'd claim it is unnecessary.

... hopefully answered above.


> > + retries_left = repair;
> > + do {
> > + read_bytes = read(ctrl, data, track_size);
> > + if (read_bytes != track_size) {
> > + if (retries_left) {
> > + format_begin(ctrl);
> > + format_track_head(ctrl, track, head);
> > + format_end(ctrl);
> > + seek_track_head (ctrl, track, head);
> > + retries_left--;
> 
> Will the retries work if IO error happens?  There are calls to err() all
> over, so am I thinking wrong the program will exit rather than re-attempt
> until retries end.

What IO error do you mean? IO errors are handled by the following condition:

  if (read_bytes != track_size) {

I tested the code with several broken floppies and it does exactly what
I wanted to achieve. You probably missed that "continue" call when at least
one retry is left. If the track is unreadable, it decreases the retry counter,
re-format the track, re-seeks the track for verification and jumps back
to the beginning of the track verification loop.

> 
> > + if (retries_left) continue;
> 
> New line & indent step missing.

I usually don't indent if well readable and other lines are longer,
but no problem with that. Can be changed.


> > @@ -108,22 +158,45 @@ int main(int argc, char **argv)
> >   int ch;
> >   int ctrl;
> >   int verify = 1;
> > + int repair = 0;
> > + int track_from = 0;
> > + int track_to = -1;
> 
> In floppy_struct track is unsigned int.  It would be best to not mix
> types unnecessarily.

The negative value is used as a flag here. -1 means it is not set
by the user and this way I reused the same variable.
I correctly retype them when needed.


> Use strtou32_or_err() and remove INT_MAX check.

Ok, had no idea it exists. Looked at few other tools and copied that.
This is a good candidate for a change.


> > + if (track_to == -1)
> > + track_to = param.track - 1;
> > +
> 
> Adding a 'user_defined_tracks' variable seems better approach, than using
> contents of the variable to figure out whether it was set or not.


This is specific to the '-t/--to' switch only. Both switches can
be used independently. You can use just one of them or both together.
The variable would have to be called 'user_defined_track_to'.


> > + if ((unsigned int)track_from > param.track - 1)
> > + err(EXIT_FAILURE, _("'from' is out of allowed range\n"));
> > + if ((unsigned int)track_to > param.track - 1)
> > + err(EXIT_FAILURE, _("'to' is out of allowed range\n"));
> > + if (track_from > track_to)
> > + err(EXIT_FAILURE, _("'from' is higher than 'to'\n"));
> 
> The err() adds new line to print out, so the messages above will print
> unexpected empty line.

This can be completely removed after the change to strtou32_or_err(), right?


Please, let me know.

Thanks,
Jaromir.

--
Jaromir Capik
Red Hat Czech, s.r.o.
Software Engineer / Secondary Arch

Email: jcapik@redhat.com
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
IC: 27690016 
