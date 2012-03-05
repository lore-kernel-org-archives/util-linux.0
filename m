Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62060 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757434Ab2CETjG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:06 -0500
Received: by eaaq12 with SMTP id q12so1565217eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:04 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: Re: [pull] fixes to todo items etc
Date: Mon,  5 Mar 2012 20:38:37 +0100
Message-Id: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <20120305123847.GD486@x2.net.home>
References: <20120305123847.GD486@x2.net.home>
References: <CAG27Bk1Lm57u2wX0LQFWhvo8kanpOF6YSt_UgsSuuOcfB1LxPg@mail.gmail.com> <20120305123847.GD486@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 5, 2012 at 13:38, Karel Zak <kzak@redhat.com> wrote:

Hi Karel et.al.

>  if you already have file descriptor then use the descriptor for
>  fchmod/fchown rather than chmod by filenames.

Fixed to patched following this mail && in my git repository.

>  Please, send all security sensitive changes (and xmkstemp() code)
>  to our mailing list for review.

Good point.  I'll send the whole change set, just in case someone wants to comment other, mostly boring, changes.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/

