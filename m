Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbcLELvb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 5 Dec 2016 06:51:31 -0500
Date: Mon, 5 Dec 2016 12:51:29 +0100
From: Karel Zak <kzak@redhat.com>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Pull request: nsenter(1) fixes
Message-ID: <20161205115129.hvxasynsgszi33tu@ws.net.home>
References: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 05, 2016 at 11:25:45AM +0100, Michael Kerrisk (man-pages) wrote:
> I have various fixes to send, but I'll start small, with a couple of
> fixes for nsenter(1).

 Applied ... but you have removed "See also.. " sentence from
 description of the --user. Would be better to keep there?

> Is a git pull request compatible with your
> workflow?

 Sure. 
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
