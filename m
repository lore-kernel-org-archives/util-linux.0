Return-Path: util-linux-owner@vger.kernel.org
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:45065 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbaAYTUf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 25 Jan 2014 14:20:35 -0500
Received: from 87-198-57-52.ptr.magnet.ie ([87.198.57.52] helo=sdfg.com.ar)
	by alerce.vps.bitfolk.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.76)
	(envelope-from <rodrigo@sdfg.com.ar>)
	id 1W7B2j-00033K-7M
	for util-linux@vger.kernel.org; Sat, 25 Jan 2014 18:45:33 -0300
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: util-linux@vger.kernel.org
Subject: fallocate: Add "--dig-holes" options and minor fixes
Date: Sat, 25 Jan 2014 19:17:25 +0000
Message-Id: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

As discussed in this[1] gmane thread, I'm submitting the funtionality to dig
holes as part of the fallocate(1) command.

When using this option, the file is searched for chunks of '\0's and digs a hole
when possible. The end result should (if a hole was found) an sparse file
created in-place.

The patchset consist of 3 patches, the first one:

	[PATCH 1/3] fallocate: Clarify that space can also be deallocated

is just a fix to make clear that the fallocate tool as already is, is capable of
dellocations too (not only preallocations).

The next 2 patches are:

	[PATCH 2/3] fallocate: Hide #ifdef tricks to call fallocate in a

	Which creates a function that has the #ifdef, that will be useful when
we call fallocate from different places in the code (i.e. in the next patch)

	[PATCH 3/3] fallocate: Add "--dig-holes" option

	That just adds the option and updates the manpage.


Comments and suggestions totally welcome! :)




Thanks a lot,
Rodrigo

[1]: http://article.gmane.org/gmane.linux.utilities.util-linux-ng/8415

