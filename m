Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60847 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbbALLZv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Jan 2015 06:25:51 -0500
Date: Mon, 12 Jan 2015 12:25:47 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] setarch: accept the option --list in any position
Message-ID: <20150112112547.GH20899@x2.net.home>
References: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
 <1420897295-17573-3-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420897295-17573-3-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 10, 2015 at 02:41:34PM +0100, Benno Schulenberg wrote:
>  sys-utils/setarch.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

 I have applied a little different version with some additional
 cleanups. Note that I think --list should be available only for
 "setarch" but no for arch specific symlinks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
