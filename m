Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61042 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794Ab2A3LIC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jan 2012 06:08:02 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0UB82XF023577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 30 Jan 2012 06:08:02 -0500
Date: Mon, 30 Jan 2012 12:08:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: memory leaks tests (Re: [PATCH] Fix a potential memory leak at
 mnt_table_parse_dir)
Message-ID: <20120130110800.GA22107@x2.net.home>
References: <20120120.130034.1018682633157048125.yamato@redhat.com>
 <20120120093433.GA13157@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120120093433.GA13157@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 20, 2012 at 10:34:33AM +0100, Karel Zak wrote:
>  It would be nice to add valgrind (or so) to the tests and check for
>  mem-leaks. (Ideally add some simple infrastructure to tests/functions.sh
>  and log valgrind output to "$TS_OUTPUT.mem".)  Volunteer? ;-)

 Implemented.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
