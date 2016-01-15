Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35734 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbcAOFjN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 15 Jan 2016 00:39:13 -0500
Received: by mail-pf0-f171.google.com with SMTP id 65so112094263pff.2
        for <util-linux@vger.kernel.org>; Thu, 14 Jan 2016 21:39:12 -0800 (PST)
Date: Thu, 14 Jan 2016 21:39:04 -0800
From: Isaac Dunham <ibid.ag@gmail.com>
To: flylehe <flylehe@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: How to obtain the manual of util-linux?
Message-ID: <20160115053903.GB10573@newbook>
References: <CAP0dga9EC649Wv04qSgythX2t+yO8gg=6TH80K6dBY4D1yUgCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP0dga9EC649Wv04qSgythX2t+yO8gg=6TH80K6dBY4D1yUgCg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 14, 2016 at 09:36:44PM -0500, flylehe wrote:
> Does util-linux have a manual, similar to coreutils' official manual
> https://www.gnu.org/software/coreutils/manual/ ?

Not in info format.

Every command is documented by a manpage (*.1 for user commands, *.8 for
administrative commands, *.5 for files, and *.3 for programming interfaces
like libblkid).

There is also plain-text documentation in Documentation/.

HTH,
Isaac Dunham
