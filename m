Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64789 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab1AAVFi (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Sat, 1 Jan 2011 16:05:38 -0500
Received: by vws16 with SMTP id 16so5256278vws.19
        for <util-linux-ng@vger.kernel.org>; Sat, 01 Jan 2011 13:05:38 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 1 Jan 2011 21:05:36 +0000
Message-ID: <AANLkTikYjykxGoLh6vmqA1ZD3UMtq=0tZNJ_ub9JK0Xy@mail.gmail.com>
Subject: Re: fdisk change proposal - fdisk (util-linux-ng 2.14)
From: Jon Grant <jg@jguk.org>
To: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Just replying about his proposed change I suggested back in 2009:

I could not find the email, but it is archived online:
http://marc.info/?l=util-linux-ng&m=123815185328131&w=2


I will create a patch to eliminate the warning when a new disklabel
has been created.  Caused by use of the "o" command, or also a new
bank disc which is filled with zeros (no disklabel present)

Current version has -h and -v, but not --help and --version. So I will
have a look at adding those two additional options.

I will endeavour to submit a patch soon. Please let me know if there
are any changes I should make to my plan for this patch!

Please include my email address in any replies.

Best regards, Jon
