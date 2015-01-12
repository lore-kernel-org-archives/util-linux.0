Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbbALLdX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Jan 2015 06:33:23 -0500
Date: Mon, 12 Jan 2015 12:33:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] setarch: in the usage text only mention options that
 actually do something
Message-ID: <20150112113318.GI20899@x2.net.home>
References: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
 <1420897295-17573-4-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420897295-17573-4-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 10, 2015 at 02:41:35PM +0100, Benno Schulenberg wrote:
> It is enough that --4gb is mentioned in the man page.
...
> -	fputs(_("     --4gb                ignored (for backward compatibility only)\n"), stdout);

I'm not sure about this kind of change. If I good remember than for
example in RH we have some QA tests to compare man page and --help.

IMHO if we have any feature/option than it's better to keep it
documented on all places.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
