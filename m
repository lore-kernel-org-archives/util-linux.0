Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46796 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbaEZKYa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 May 2014 06:24:30 -0400
Date: Mon, 26 May 2014 12:24:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Fwd: Bug#747948: mount: should warn user when potentially
 incorrect fstab order
Message-ID: <20140526102426.GF2968@x2.net.home>
References: <20140513100450.GA1083@europecamions-interactive.com>
 <5372173E.7090002@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5372173E.7090002@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 13, 2014 at 08:59:42AM -0400, Phillip Susi wrote:
> Here is the problem: currently, at start, filesystems referenced in
> fstab are mounted following their order in fstab. The problem is, when

 I have added a note to the mount man page.

 Not sure if we want to add so complex fstab checking code to mount -a.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
