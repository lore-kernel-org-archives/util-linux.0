Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64383 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423Ab1H2JSH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Aug 2011 05:18:07 -0400
Date: Mon, 29 Aug 2011 11:18:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Pierre Gaston <pierre.gaston@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: example in flock manpage still not useful.
Message-ID: <20110829091804.GG1855@nb.net.home>
References: <CAPSX3sTRT7zOZALF2CHUdgRuz3Gz4PyXtxmDB6nhVa7VwK7RDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPSX3sTRT7zOZALF2CHUdgRuz3Gz4PyXtxmDB6nhVa7VwK7RDQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 25, 2011 at 03:26:14PM +0300, Pierre Gaston wrote:
> flock -n 9 || exit 1                 # exit if the lock can't be acquire.

 Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
