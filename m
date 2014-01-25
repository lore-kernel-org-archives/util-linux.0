Return-Path: util-linux-owner@vger.kernel.org
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:45069 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaAYTZe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 25 Jan 2014 14:25:34 -0500
Received: from 87-198-57-52.ptr.magnet.ie ([87.198.57.52] helo=sdfg.com.ar)
	by alerce.vps.bitfolk.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.76)
	(envelope-from <rodrigo@sdfg.com.ar>)
	id 1W7B7Z-00038s-AP
	for util-linux@vger.kernel.org; Sat, 25 Jan 2014 18:50:33 -0300
Date: Sat, 25 Jan 2014 19:23:03 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: util-linux@vger.kernel.org
Subject: Re: fallocate: Add "--dig-holes" options and minor fixes
Message-ID: <20140125192303.GA7455@sdfg.com.ar>
References: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 25, 2014 at 07:17:25PM +0000, Rodrigo Campos wrote:
> Hi,
> 
> As discussed in this[1] gmane thread, I'm submitting the funtionality to dig
> holes as part of the fallocate(1) command.

Ohh, forgot to tell, but I tried to re-use already used strings in _("")
contructors and make "perror" just print the function name, as that is what I
observed in other util-linux tools.

If I missed something, please let me know :)




Thanks again.
Rodrigo
