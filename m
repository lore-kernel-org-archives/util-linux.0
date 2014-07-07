Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43188 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957AbaGGTK5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jul 2014 15:10:57 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4E29E2199C
	for <util-linux@vger.kernel.org>; Mon,  7 Jul 2014 15:10:56 -0400 (EDT)
Message-Id: <1404760256.26848.139006189.2A44DDD8@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: 2.25-rc2: No package 'python-2.6' found?
Date: Mon, 07 Jul 2014 21:10:56 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

Running ./configure in ~/util-linux-2.25-rc2/, I run into this:

-----
checking for a Python interpreter with version >= 2... python
checking for python... /usr/bin/python
checking for python version... 2.6
checking for python platform... linux2
checking for python script directory... ${prefix}/lib/python2.6/dist-packages
checking for python extension module directory... ${exec_prefix}/lib/python2.6/dist-packages
checking for PYTHON... no
configure: error: Package requirements (python-2.6) were not met:

No package 'python-2.6' found

Consider adjusting the PKG_CONFIG_PATH environment variable if you
installed software in a non-standard prefix.

Alternatively, you may set the environment variables PYTHON_CFLAGS
and PYTHON_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.
-----

On a newer system (Mint Petra), the same thing happens, but
then mentioning 2.7.

What is it wanting to see where?

Benno

-- 
http://www.fastmail.fm - Or how I learned to stop worrying and
                          love email again

