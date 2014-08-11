Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:42268 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465AbaHKOrN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Aug 2014 10:47:13 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id DC82DAC1F
	for <util-linux@vger.kernel.org>; Mon, 11 Aug 2014 14:47:11 +0000 (UTC)
Message-ID: <1407768431.5984.23.camel@oct.suse.cz>
Subject: util-linux and distro bootstrap, dependencies and build cycles
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Mon, 11 Aug 2014 16:47:11 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo.

Our distro build team has problems with the new util-linux. util-linux
is one of the low level packages. Now it depends on a two high level
packages with lots of dependencies:

systemd
python

Complete safe bootstrap distro rebuild requires two rebuilds of all
packages in the dependency cycle: one after initial util-linux rebuild
and second after high level dependency rebuild and consequent second
util-linux rebuild.

The build cycle util-linux <-> python is far the largest build cycle. In
case of forthcoming SLES12 it triggers rebuild of 2921 packages!

I was asked to solve this problem, and I created a solution that makes
possible to build:
util-linux stage 1: Everything except stuff that supports systemd and
  python-libmount
util-linux stage 2: Stuff that supports systemd (lslogins, logger, uuidd
  and fstrim service files) using installed low level stage 1 stuff.
python-libmount: Python bindings only using installed stage 1 stuff.

This is now implemented by a set of sed scripts on top of .am and .ac
sources. But I would like to create more generic solution.

What do you think about one of the following solutions?:

Solution 1:

Modify make system by adding:
--enable-build-stage-1: Distro bootstrap stage 1: Build only code
    without systemd and python dependencies.
--enable-build-stage-2: Distro bootstrap stage 2: Build code with
    systemd dependencies (even if they are optional). Use installed
    instances of libmount, libblkid, libsmartcols and libuuidd, do not
    build them in-tree.
--enable-build-stage-3: Distro bootstrap stage 3: Build python-libmount
    only. Use installed instance of libmount, do not build them in-tree.

Solution 2:

--enable-build-stage-1 and --enable-build-stage-2 exactly as above.

Split python-libmount into a separate project.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

