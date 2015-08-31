Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20150831085338.GB2726@ws.net.home>
References: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
	<20150831085338.GB2726@ws.net.home>
Date: Mon, 31 Aug 2015 12:09:31 +0100
Message-ID: <CAG27Bk26vdapPs5FiA5n6hxmSEmPHGKgBSJdtLyR=69LNsSj7Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] pull: cal: --sunday --week numbering correction
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 31 August 2015 at 09:53, Karel Zak <kzak@redhat.com> wrote:
>>   cal: replace magic constants with symbolical values
>>   cal: check biggest week number correctly when highlighting
>>
>>  misc-utils/cal.c            | 102 +++---
>>  tests/expected/cal/bigyearw | 156 ++++-----
>>  tests/expected/cal/colorw   |  48 +--
>>  tests/expected/cal/jan1753  |  12 +-
>>  tests/expected/cal/sep1752w | 148 ++++----
>>  tests/expected/cal/weekarg  |  60 ++--
>>  tests/expected/cal/weeknum  | 816 ++++++++++++++++++++++----------------------
>>  tests/ts/cal/weekarg        |  26 ++
>
> this diffstat does not match with patches you send to the list. It
> seems you forgot to send updated tests.

I don't understand how missing a patch in between is even possible
when using 'git send-emails 00*' style command. Oh well, maybe I just
need to be triple sure in future what I'm submitting to mail list.

> I have updated the tests
> manually. Please, git-pull & review.  Thanks.

All looks good, thanks Karel.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
