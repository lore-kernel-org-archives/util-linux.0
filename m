Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34968 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbcLEVhF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 5 Dec 2016 16:37:05 -0500
Received: by mail-qt0-f196.google.com with SMTP id m48so37720767qta.2
        for <util-linux@vger.kernel.org>; Mon, 05 Dec 2016 13:37:03 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <d94b2af3-fe84-21be-9e41-3b3668729524@gmx.com>
References: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
 <20161205115129.hvxasynsgszi33tu@ws.net.home> <d94b2af3-fe84-21be-9e41-3b3668729524@gmx.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 5 Dec 2016 21:37:02 +0000
Message-ID: <CAG27Bk30ckZPZQ8M5K-o0nEEdd64pHGMfP2mPGdgpmpvu+1jvg@mail.gmail.com>
Subject: Re: Pull request: nsenter(1) fixes
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 5 December 2016 at 18:27, J William Piggott <elseifthen@gmx.com> wrote:
> On 12/05/2016 06:51 AM, Karel Zak wrote:
>> On Mon, Dec 05, 2016 at 11:25:45AM +0100, Michael Kerrisk (man-pages) wrote:
>>> I have various fixes to send, but I'll start small, with a couple of
>>> fixes for nsenter(1).
>>
>>  Applied ... but you have removed "See also.. " sentence from
>>  description of the --user. Would be better to keep there?
>>
>>> Is a git pull request compatible with your
>>> workflow?
>>
>>  Sure.
>
> Does this apply to all of us? We no longer need to submit patches to the
> mailing list for peer review?

IMHO in best case both emails & remote repository.

I like emails because they end getting indexed by web search engines, and
there is good change of finding why something was done after years has
passed.  Email stream is also nice to read.  I do read all changes that come
to this list although I might not say anything most about them.

That said remote repositories has their nice sides.  For example some of my
commits are signed[1], while other are not[2].  Since mails do not have gpg
signature it's pretty clear Karel is merging patches from both mailbox and
my remote repository.  Also testing is nicer when I can use someone's remote
repository to pull their branch.

[1] git show --show-signature 00971cca8a270b6e162c977182d134a64bbc914a
[2] ^^ 0b404f0845fe97f84e45f9b7b23e9e1814d3ef4e

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
