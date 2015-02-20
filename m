Return-Path: util-linux-owner@vger.kernel.org
Received: from wp221.webpack.hosteurope.de ([80.237.132.228]:57171 "EHLO
	wp221.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754214AbbBTKZ1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Feb 2015 05:25:27 -0500
Received: by jue.netz (masqmail 0.3.5, from userid 500)
	id 1YOkTv-0gP-00
	for <util-linux@vger.kernel.org>; Fri, 20 Feb 2015 11:06:47 +0100
Date: Fri, 20 Feb 2015 11:06:47 +0100
From: Juergen Daubert <jue@jue.li>
To: util-linux@vger.kernel.org
Subject: [bug] logger 2.26: regression, option -i not combinable with other
 options
Message-ID: <20150220100647.GA2624@jue.netz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

with logger from util-linux 2.25.x it's possible to combine the option
-i with other options like:

 logger -is

with 2.26 I get the following error message:

 $:~> logger -is
 logger: failed to parse id: 's'

The changed behaviour breaks existing scripts like dhcpcd-run-hooks [1]
from dhcpcd [2].


Posible solution:
- don't combine the -i and --id options but keep the behaviour of -i and
  make --id a long-form only option. 


Thanks and best regards
Juergen


[1] http://roy.marples.name/projects/dhcpcd/artifact/953bd27
[2] http://roy.marples.name/projects/dhcpcd/index

