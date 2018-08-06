Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbeHFJED (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Aug 2018 05:04:03 -0400
Date: Mon, 6 Aug 2018 08:56:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Dmitry V. Levin" <ldv@altlinux.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: use kernel crypto api
Message-ID: <20180806065621.ju4e3ifodzcc7kjk@ws.net.home>
References: <20180804191706.10641-1-kerolasa@iki.fi>
 <20180804194655.GD4461@thunk.org>
 <alpine.LNX.2.21.99.1808051124370.868@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.21.99.1808051124370.868@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 05, 2018 at 11:42:09AM +0100, Sami Kerola wrote:
> I should have told in that commit message part of the motivation was to 
> deprecate util-linux local md5 implementation.

Hmm... it will be difficult if we want to support non-Linux systems
(GNU Hurd, OSX, BSD) for some of our tools ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
