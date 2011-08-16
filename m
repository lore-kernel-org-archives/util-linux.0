Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39961 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab1HPKjm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Aug 2011 06:39:42 -0400
Date: Tue, 16 Aug 2011 12:39:37 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Benno Schulenberg <bensberg@justemail.net>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: man-pages and usage() howto
Message-ID: <20110816103937.GH1843@nb.net.home>
References: <20110815141948.GH2038@nb.net.home> <CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 15, 2011 at 09:12:16PM +0200, Sami Kerola wrote:
> On Mon, Aug 15, 2011 at 16:19, Karel Zak <kzak@redhat.com> wrote:
> > Sami is already working on some howtos, what we need is some
> > consensus about a way how describe options.
> 
> What I wrote about various things can be found from github. I'd say
> that so far the Documentation directory patch set is a proposal, which
> can and should change.

 Yep, I think we can make it "perfect" in your githup repository
 before we merge it upstream ;-)

> I used GNU notation which has 'unnecessary' equals sign.

[...]

> IMHO the visual unity is better.

 I understand, but I'm not sure about readability... well, I have asked
 my colleagues and the winer is:

    --date <time>
    
 the important is visual difference between static option name and variable
 option argument.

 You can hate me, but we need any decision. I'll cleanup the usage()
 strings now.

> So the howto should tell how do you know you are dealing with
> fundamental difference of outcome, which requires multiple synopsis
> lines. Obvious trap seems to be such hermeneutic circle that no-one
> understands what the howto tries to say. Rigour rejection until the
> text is good is needed.

 I think we have to use common sense here. Sometimes multiple synopsis
 lines makes sense (losetup -h ?). There is not necessary any strict
 rule.

 [...]

> Assuming this approach sounds good the question is shall we write
> shortest or longest possible list of well known options list? I'm in
> favour of short list because it requires less maintenance.

 Sure, I agree.

 I'm just working on Benno's patches and I found that we need some
 explicitly defined rules for usage():

    - "Usage:" and "Options:" use separate lines and strings, before
       the sections has to be empty line:

       fputs(_("\nUsage:\n"), out);
       ...
       fputs(_("\nOptions:\n"), out);

     (so this two string will be translated only once)

   - all lines with options and synopsis are prefixed 
     by ***one*** space (0x40):

       fputs(_("\nUsage:\n"), out);
       fprintf(out,
             _(" %s [options]\n"), something);

       fputs(_("\nOptions:\n"), out);
       fputs(_(" -b, --bar            this is bar\n");

   - in the code all strings with options have to start at the same
     position. It means:

     fprintf(out, _(" -x[=<foo>]   default foo is %s"), x);
     fputs(       _(" -y         some text"), out);

   - the first and last usage() output line is empty

   - the last line does not have to be empty if there is additional
     info about a man page "For more details see foo(1)."

   - use manageable chunks for the usage strings (one or few lines)

   - separator between short and long options is comma and one space:
     " -x, --long-x "

 Comments?

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
