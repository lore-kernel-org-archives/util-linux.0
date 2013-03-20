Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20130320125616.GA14833@x2.net.home>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
	<1363477219-29245-7-git-send-email-kerolasa@iki.fi>
	<20130320125616.GA14833@x2.net.home>
Date: Wed, 20 Mar 2013 14:03:19 +0000
Message-ID: <CAG27Bk1R_juhAC7wt-7Jc-F2Yg6o5AaKJmqpz0-trPqNevgEng@mail.gmail.com>
Subject: Re: [PATCH 6/7] whereis: canonicalize files before printing
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 20, 2013 at 12:56 PM, Karel Zak <kzak@redhat.com> wrote:
> On Sat, Mar 16, 2013 at 11:40:18PM +0000, Sami Kerola wrote:
>> The whereis gives promise to find files so it seems to be more correct
>> print symlink destinations than locations of symlinks.
>
>  Not sure. I think it's correct to canonicalize directory paths (to
>  avoid problems like /bin -> /usr/bin symlinks), but I don't see
>  a reason to canonicalize whole paths (filenames).
>
>  For example
>
>     $ whereis -b bzcat
>     bzcat: /usr/bin/bzcat
>
>  is expected answer, but
>
>     $ whereis -b bzcat
>     bzcat: /usr/bin/bzip2
>
>  looks strange. The another story is that many things are redirected
>  by symlinks to /etc/alternatives and then to pretty specific places.
>
>  Maybe we can add an option to canonicalize, but from my point of view
>  it should not be enabled by default.
>
>  I have applied patch to canonicalize directory names.

Hi Karel,

Thank you for the additional work put to whereis(1) patch series.

I agree. Additional --canonical option is right way to expose where
files are. I will have a look of this sometime later the week(end).

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
