Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f44.google.com ([209.85.220.44]:51102 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbaBQJBw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 17 Feb 2014 04:01:52 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so15083766pab.3
        for <util-linux@vger.kernel.org>; Mon, 17 Feb 2014 01:01:51 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <7637074.9zSARVxuln@vapier>
References: <1389816953-11531-1-git-send-email-kerolasa@iki.fi>
	<1389816953-11531-3-git-send-email-kerolasa@iki.fi>
	<7637074.9zSARVxuln@vapier>
Date: Mon, 17 Feb 2014 09:01:51 +0000
Message-ID: <CAG27Bk1tf+OLsOrhCWA9e6ZrPOF7K779rq_9FKD-_Sj0H7idUg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests: automatic whitespace trimming broke earlier commit
From: Sami Kerola <kerolasa@iki.fi>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 17 February 2014 08:31, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday, January 15, 2014 20:15:53 Sami Kerola wrote:
>> Setting in .gitconfig to do 'git apply --whitespace=fix' automatically
>> turned automation against user.
>
> seems like git settings are still breaking these tests ?  commit
> c367cda936f301b3d116a587356594b038de6d04 in the tree doesn't modify anything
> and three of the cal tests are failing because of trailing whitespace
> differences.

Hi Mike,

I found out the same, and mentioned about it in build target pull request.

http://www.spinics.net/lists/util-linux-ng/msg08858.html

This time I am pretty sure I sent the trailing spaces in patch, and
they seem to be present in archive.

http://www.spinics.net/lists/util-linux-ng/msg08752.html

Karel, is it possible something in your setup is removing trailing
spaces? Perhaps you could  simply copy the cal test outputs to
expected directory, so that we can rid of this issue for good.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
