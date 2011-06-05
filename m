Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61867 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab1FESrt convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 5 Jun 2011 14:47:49 -0400
Received: by qwk3 with SMTP id 3so1388690qwk.19
        for <util-linux@vger.kernel.org>; Sun, 05 Jun 2011 11:47:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20110601081046.GE25562@nb.net.home>
References: <1306270604-6154-1-git-send-email-kerolasa@iki.fi>
	<20110601081046.GE25562@nb.net.home>
Date: Sun, 5 Jun 2011 20:47:48 +0200
Message-ID: <BANLkTindk_vPdnzXmL8dkzeQj+WdG3cnFw@mail.gmail.com>
Subject: Fwd: [PATCH 00/13]: text-utils fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 1, 2011 at 10:10, Karel Zak <kzak@redhat.com> wrote:
>> All patches are available from github in branch text-utils.
>> git://github.com/kerolasa/lelux-utiliteetit.git
>
>  All applied, except patches 8, 9 and 10.

I took a look of the rejected patches.

[PATCH 08/13] col
> Why we need this magical (INT_MAX / 2) limit?

The col command is counting stuff in half lines i.e. the counts are
double what one would intuitively think. I wrote the code segment
different way, and commented it. Perhaps the lines are more
understandable now.

[PATCH 09/13] colrm
> and
> bindtextdomain(PACKAGE, LOCALEDIR);
> textdomain(PACKAGE);
> right?

Wilco.

I amend the fixes, and pushed with force to repository.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
