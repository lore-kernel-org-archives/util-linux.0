Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34628 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753828AbcD1WCL (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Apr 2016 18:02:11 -0400
Message-ID: <1461880928.2307.48.camel@HansenPartnership.com>
Subject: Unprivileged containers and co-ordinating user namespaces
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org, systemd-devel@lists.freedesktop.org
Date: Thu, 28 Apr 2016 15:02:08 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It's always been annoying to me that we never co-ordinate our use of
namespace resources, but it's never really mattered until the user
namespace came along because namespaces didn't overlap and the only
annoyance was not being able to use existing tools to manipulate other
containers (mainly not being able to us ip netns).

However, with the user namespace, it's become necessary to co-ordinate
if you're giving users a range of uids beyond their own because you
don't want to have two separate container users owning overlapping uid
numbers (especially if they're unprivileged) because that will lead to
all sorts of security issues.  I think we need two things: a file
describing this for other things (like container orchestration systems
that want to know) and a mechanism for delegating the alloted uids to
the user.  One possible way of doing this would be to have the init
system set up the correctly owned user namespace at boot time.  It's
appealing to have the user sort out their own administration by simply
spawning new child user namespaces, but it adds the complexity that we
have to know what we're mapping to inside the namespace, whereas all
the administrator really cares about is what exterior uid range is
allocated (and that it remain that same range between reboots, because
these are the uids that's going to appear on disk).

Assuming everyone agrees it's a file and a utility, I'd propose the
file be

/etc/usernamespaces

and the format be <user>:<start>:<length>:<flags>

For the allocated uids.  <user>,<start> and <length> are obvious but
<flags> would be used for things like deny setgroups and possibly other
privilege reductions.

Then we need a utility, say userns that has cap_setuid+cap_setgid and
takes as an argument the raw uid_map, gid_map the user wants to install
plus similar arguments to unshare.  It then validates that the exterior
range are allowed by /etc/usernamespaces and sets up the usernamespace
with that range owned by the invoking user.

Container orchestration systems can either register their (probably
huge) ranges in the file, or simply use the file to know what ranges to
avoid.

If this sounds OK to people, I can code up a utility that does this,
which should probably belong in util-linux.

James

