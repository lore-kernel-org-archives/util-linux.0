Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:54605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbdF1V77 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 17:59:59 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: [PATCH 6/6] misc: update --help content again
Date: Wed, 28 Jun 2017 23:59:55 +0200
Cc: util-linux@vger.kernel.org
References: <20170626182952.15988-1-sweet_f_a@gmx.de> <1076b7a3-6e0f-6e38-0486-a08de23a4f91@gmx.de> <60165400-ce08-fb7a-f435-681a10511fe9@gmx.com>
In-Reply-To: <60165400-ce08-fb7a-f435-681a10511fe9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201706282359.55888.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 27 June 2017, J William Piggott wrote:
> On 06/27/2017 12:35 PM, Rüdiger Meier wrote:
> > On 06/27/2017 05:12 PM, J William Piggott wrote:
> >> On 06/27/2017 09:26 AM, Rüdiger Meier wrote:
> >>> On 06/27/2017 02:42 PM, J William Piggott wrote:
> >>>> On 06/26/2017 02:29 PM, Ruediger Meier wrote:
> >>>>> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >>>>> We change
> >>>>>
> >>>>>
> >>>>> -h, --help    display this help and exit
> >>>>> -V, --version output version information and exit
> >>>>>
> >>>>> to
> >>>>>
> >>>>> -h, --help    display this help
> >>>>> -V, --version print version
> >>>>>
> >>>>> Some thoughts about this:
> >>>>>
> >>>>>     * use "display" for --help because it matches better if we
> >>>>>       would add pager support (like git --help)
> >>>>>
> >>>>>     * "print" for --version to be different
> >>>>
> >>>> To be different why?
> >>>
> >>> Because AFAIR somewhere Karel or somebody else mentioned that we
> >>> could add auto-pager support on terminal for long --help output
> >>> (like findmnt) or otherwise colored help texts.  This would be a
> >>> difference, doing more than printf only.
> >>
> >> If I understand you correctly, using the word 'display' should
> >> imply that a pager might be used?
> >>
> >> When reading open source documentation, messages, etc., I make
> >> absolutely no distinction between: show, to stdout, display,
> >> print, or output; to me they are absolute synonyms unless there is
> >> additional language stating otherwise; such as:
> >
> > Maybe I make this difference between display and print because
> > there is a *print*() function in almost any programming language I
> > know. But *display*() or *show*() are usually only known in any
> > graphical libraries (widget toolkits, plotting, etc.).
>
> Okay, I get that. It seems that there is a conflict between what
> makes sense to a programmer, and what makes sense to a user.
>
> How about this: programmatically print is ambiguous also. It can be
> print to file, var, screen. So your associating the term 'display'
> with gui tools should create a connection to the display device. I
> think that is the goal here. A one-word term that connects an action
> with a device.
>
> > BTW regarding show, see
> >
> > --status     don't output anything, status code shows success
> > So something can be "shown" without any output at all ;)
>
> Show, would not be my first choice. The reason I favor 'display' is
> because it is a synonym for a terminal monitor. So using it as a verb
> hints at the intended target device. It also avoids the ambiguity as
> to whether 'print' means 'print to screen', 'print to printer', or
> perhaps something else. Same problem with 'output'. I think most,
> programmers and users, would interpret 'display' as being sent to the
> display device (pager or not). For conciseness in places like
> usage(), display is an attempt to imply the device. I don't think any
> of the other synonyms can do that.
>
> >>> --version just print and exit
> >>>
> >>> --help   display something and keep the display (pager) open.
> >>
> >> With this additional language it makes no difference for us
> >> whether we use the same term, print or display, in both
> >> statements.  But to a new student of open source using different
> >> terms changes the meaning; or at the very least is ambiguous. 
> >> They may wonder: there must be a reason they are using these
> >> different terms; what is it?
> >>
> >>>> It makes it sound like help and version will not have the same
> >>>> action.  Laymen think 'print' means send to the printer.
> >>>>
> >>>> Translators will have to figure out which different words to
> >>>> use.
> >>>
> >>> Hehe, I have never thought about printers.  But for my bad
> >>> English "display" sounds more like TV show or graphical
> >>> X-display.  ;)
> >>>
> >>> Seriously IMO "print" is the right term for command-line and
> >>> shell environment .  It's also more often used than "display" in
> >>> POSIX and coreutils manpages.
> >>
> >> Using the term 'print' is residue from the days when a printer was
> >> the only human readable output.  I think it is unfortunate that it
> >> has now become synonymous with sending output to the terminal
> >> display monitor.
> >>
> >> However, whatever the consensus is for the best term, all I'm
> >> hoping for is to use it consistently instead of all the other
> >> synonyms.
> >>
> >>>> What is broken by:
> >>>>
> >>>>    -h, --help    display this help
> >>>>    -V, --version display version
> >>>>
> >>>>
> >>>> I really think it is a good idea to use consistent language for
> >>>
> >>> Consistent language is not always human-friendly
> >>
> >>   For comprehension of technical material, consistency is not only
> >>   more human-friendly, it is imperative.
> >>
> >>> and can also be more hard or boring to read.  See
> >>
> >> We are not talking about a novel.  Technical material by necessity
> >> is boring to read (unless you are enthusiastic about learning). 
> >> Think textbooks.
> >
> > Yes, but I find my eyes are more relaxed when not everything looks
> > like the same pattern with minor differences.  Worst case example:
> >
> >
> > --show-file-size     display the size of the file
> > --show-link-size     display the size of the link
> > --show-file-color    display the color of the file
> > --show-link-color    display the color of the link
> > --show-file-taste    display the taste of the file
> > --show-link-taste    display the taste of the link
> >
> > This makes me ill. So I don't like to read the term "display" or
> > "print" 20 times on the same screen.  The --help and --version
> > options are boring enough already. I see no problem mixing print
> > and display there.
> >
> > A bit reordering and rewording makes it better:
> >
> >
> > --show-file-size     display the size of the file
> > --show-file-color    display the color of the file
> > --show-file-taste    display the taste of the file
> > --show-link-size     print link size
> > --show-link-color    print link color
> > --show-link-taste    print link taste
>
> I understand your position. Personally, I think being ambiguous to
> gain readability is a poor trade off for technical information. The
> above implies that there is something different between the first
> three and the last three.
>
> >>>> comparable actions.  It is easier to comprehend, especially for
> >>>> non-native speakers.  Once they understand the meaning of a
> >>>> term, possibly from a context that they the understand well,
> >>>> then that knowledge is transferable to other contexts.  Why add
> >>>> confusion by constantly interchanging term synonyms?
> >>>
> >>> Anyways, I'm also fine with display.  This was just my favorite
> >>> proposal.
> >>
> >> I know when it comes to docs and strings that there is a long
> >> tradition for hackers interjecting humor, wisecracks and generally
> >> not taking things to seriously.  I'm generally of that mindset
> >> myself.  However, it wasn't so long ago when I began using Linux
> >> that I cannot remember being confused by all of the interchanging
> >> of synonyms. Promoting this idea of using consistent language
> >> doesn't matter that much to me personally, I'm trying to help new
> >> students.
> >
> > FYI I just investigated the coreutils history.  They changed their
> > strings the last time in 1993.  Maybe that's also kind of
> > consistent in tradition.
> >
> >
> > This was their change 24 years ago
> >
> > -     --help             provide this help\n\
> > -     --version          show program version\n");
> >
> > +     --help             display this help and exit\n\
> > +     --version          output version information and exit\n");
>
> That's an interesting change. I don't know that I'd call it an
> improvement. I wonder if they went through the same discussions as we
> are.

Hehe, my major point was, that it's actually stupid that we discuss 
about this at all. (Probably that's why nobody else joined the 
discusson ;) Venerable coreutils developers came to a *final* decision 
24(!) years ago and never changed it since then! *We* where using the 
*same* strings already, translations too, no complaints ever. Why do we 
touch this at all? Why not accept the state? It's almost blasphemy to 
impeach these strings. ;)

util-linux plus coreutils would mean about more than 200 comands on a 
usual Linux system would use the same style (consensus!). Other 
projects also follow coreutils when thinking about CLI style.

Anyways ... I'm really happy that our strings are quite shorter now. If 
you wouldn't have started to change the strings then I wouldn't have 
done anything. My only real complaints about your original change were:

  1. Why change at all?
  2. Why remove "this"?
  3. If change, why not at least shorter?

;)

> > Grepping all their manpages shows that they are using "display"
> > almost only in this single help string, normally using "print" and
> > sometimes "show".
> >
> > In their real (info) documentation they use:
> >
> > `--help'
> >      Print a usage message listing all available options, then exit
> >      successfully.
> >
> > `--version'
> >      Print the version number, then exit successfully.
>
> At least they used 'print' in both of them. Although I don't love the
> term 'print', my goal would be met if it was just used consistently.
>
> Well, can see why this as never been addressed. If two people cannot
> come to a consensus, than how will the project as a whole, or the
> entire open source community. I guess I'll leave this can-of-worms
> alone and agree to disagree.
>
> > I think these ones would fit also for our manpages.  I like their
> > statement "listing *all* available options".  It was not always
> > clear to me whether
> >
> > or not I should hide unimportant/redundant options from --help
> > output.
> >
> > cu, Rudi
> >
> >> I also have the impression that many of us are working to make
> >> open source polished and professional.  I believe that technical
> >> writing
> >>
> >> should be focused on comprehension and that using consistent
> >> language, especially for terms, is imperative to that end.
> >
> > -- To unsubscribe from this list: send the line "unsubscribe
> > util-linux" in
> >
> > the body of a message to majordomo@vger.kernel.org
> >
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


