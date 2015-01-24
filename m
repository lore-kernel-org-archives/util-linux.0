Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:32946 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752467AbbAXRXi (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 24 Jan 2015 12:23:38 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5D6C92068F
	for <util-linux@vger.kernel.org>; Sat, 24 Jan 2015 12:23:35 -0500 (EST)
Message-Id: <1422120215.1322663.218300697.5A4C9C5F@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Yuri Chornoivan <yurchor@gmail.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>,
        Yuri Chornoivan <yurchor@ukr.net>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1422083931-24410-1-git-send-email-yurchor@ukr.net>
References: <1422083931-24410-1-git-send-email-yurchor@ukr.net>
Subject: Re: [PATCH] Fix various minor typos
Date: Sat, 24 Jan 2015 18:23:35 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello Yuri,

On Sat, Jan 24, 2015, at 08:18, Yuri Chornoivan wrote:
> --- a/Documentation/releases/v2.25-ReleaseNotes
> +++ b/Documentation/releases/v2.25-ReleaseNotes
> @@ -203,7 +203,7 @@ cal:
>     - mention where Gregorian reformation happen in September 1752  [Sami Kerola]
>     - remove optional from short arg -w  [Tommi Kyntola]
>     - remove unnecessary static variables  [Sami Kerola]
> -   - remove unnused structure and definition  [Sami Kerola]
> +   - remove unused structure and definition  [Sami Kerola]

These lines were automatically generated from commit messages;
if you change them in the release notes, they cannot be used
anymore to find the corresponding commit.

All the other changes are good, except for this one:

> -			fdisk_warnx(cxt, _("unssuported GPT attribute bit '%s'"), p);
> +			fdisk_warnx(cxt, _("unsuported GPT attribute bit '%s'"), p);

You missed the single that should be a double p.
But I think you caught all the other typos.  :)

Some of them I already corrected in this patch:
http://www.spinics.net/lists/util-linux-ng/msg10888.html
If you exclude those from your patch, it will then apply after
mine without conflict.

Benno

-- 
http://www.fastmail.com - Email service worth paying for. Try it for free

