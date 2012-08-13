Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16244 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab2HMOmK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Aug 2012 10:42:10 -0400
Date: Mon, 13 Aug 2012 16:42:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Naja Melan <najamelan@autistici.org>
Cc: util-linux@vger.kernel.org
Subject: Re: umount failing on paths which end in a backslash
Message-ID: <20120813144204.GF21956@x2.net.home>
References: <20120810234435.6af1f6d1@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120810234435.6af1f6d1@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 10, 2012 at 11:44:35PM +0200, Naja Melan wrote:
> I tried to report this bug months ago to the debian maintainers of
> mount, but debian bug reporting is a minefield and by email all I
> got was a lousy answer from someone who didn't understand escaping
> in bash strings and who obviously never ran the script demonstrating
> the issue.

 Fixed. It seems like a pretty old bug (v2.19 or so...). Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
