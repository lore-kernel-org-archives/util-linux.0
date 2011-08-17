Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110816104652.GA14535@nb.net.home>
References: <20110815141948.GH2038@nb.net.home>
	<CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
	<1313485424.19019.140258130122469@webmail.messagingengine.com>
	<20110816104652.GA14535@nb.net.home>
Date: Wed, 17 Aug 2011 15:07:44 +0200
Message-ID: <CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com>
Subject: Re: man-pages and usage() howto
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 16, 2011 at 12:39, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Aug 15, 2011 at 09:12:16PM +0200, Sami Kerola wrote:
>> I used GNU notation which has 'unnecessary' equals sign.
> [...]
>> IMHO the visual unity is better.
>
>  I understand, but I'm not sure about readability... well, I
>  have asked my colleagues and the winer is:
>
>    --date <time>
>
>  the important is visual difference between static option name
>  and variable option argument.

Diamond brackets make visual difference to look quite nice. I do
like this.

 -n, --no-argument     this option requires no_argument
 -o, --optional[=3Darg]  this option has optional_argument
 -r, --required <arg>  this option requires required_argument

>  You can hate me, but we need any decision. I'll cleanup the
>  usage() strings now.

Hate? No way! Decision after fair discussion is something I
greatly value, even I could have had heretic wrong opinions
during conversation. The hate is reserved for unjust decisions.

>> So the howto should tell how do you know you are dealing with
>> fundamental difference of outcome, which requires multiple
>> synopsis lines. Obvious trap seems to be such hermeneutic
>> circle that no-one understands what the howto tries to say.
>> Rigour rejection until the text is good is needed.
>
>  I think we have to use common sense here. Sometimes multiple
>  synopsis lines makes sense (losetup -h ?). There is not
>  necessary any strict rule.

I likely made that sound over complicated. I know what I want to
mean, the next thing is to write it understandable way down. Key
word is not write but understandable, which makes this difficult
if anything.

>  I'm just working on Benno's patches and I found that we need
>  some explicitly defined rules for usage():
>
>    - "Usage:" and "Options:" use separate lines and strings, before
>       the sections has to be empty line:
>
>       fputs(_("\nUsage:\n"), out);
>       ...
>       fputs(_("\nOptions:\n"), out);
>
>     (so this two string will be translated only once)

How putting to c.h the following?

#define USAGE_HEADER _("\nUsage:\n")
#define USAGE_OPTIONS _("\nOptions:\n")
#define USAGE_SHORT_TAIL _("\n")
#define USAGE_MAN_TAIL _("For more details see %s.")

Rest should be obvious.

Having also definition for OPTION_HELP && OPTION_VERSION would be
good.

>   - all lines with options and synopsis are prefixed
>     by ***one*** space (0x40):
>
>       fputs(_("\nUsage:\n"), out);
>       fprintf(out,
>             _(" %s [options]\n"), something);
>
>       fputs(_("\nOptions:\n"), out);
>       fputs(_(" -b, --bar            this is bar\n");

Assuming we end up using definitions this does not have to be
that specific.

>   - in the code all strings with options have to start at the same
>     position. It means:
>
>     fprintf(out, _(" -x[=3D<foo>]   default foo is %s"), x);
>     fputs(       _(" -y         some text"), out);

I agree.

>   - the first and last usage() output line is empty
>
>   - the last line does not have to be empty if there is
>     additional info about a man page "For more details see
>     foo(1)."

Yes, and the definitions...

>   - use manageable chunks for the usage strings (one or few lines)

Sound reasonable, I'll add this to howto.

>   - separator between short and long options is comma and one space:
>     " -x, --long-x "

I agree, and adding to howto is needed.

On Tue, Aug 16, 2011 at 12:46, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Aug 16, 2011 at 11:03:44AM +0200, Benno Schulenberg wrote:
>> >        command [options] file
>>
>> If in the usage() help text the arguments of options are
>> written in uppercase, wouldn't it be more consistent to then
>> also write the
>
>  It depends, Semi's version is uppercase, but my (findmnt,
>  blkid, lsblk, ...) is <lowercase> :-)

I made my own office vote. The seasoned command line guys, by
clear margin, voted for lower case. Explanation why I wrote
originally with upper case was a copy how GNU does it, but as the
results show people do not like it.

>> About the other things I have not yet an opinion.
>
>  I made the decision, --option <argument>. We can play with it
>  little bit more in the next release. Now I'd like to release
>  it...
>
>  It would be also nice to sync man pages with usage() format.
>  Note that man pages changes are acceptable for -rc2.

Sounds that the version 2.21 will have hefty amount of usage(),
man page and documentation changes. I hope all is done by Jan
2012.

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
