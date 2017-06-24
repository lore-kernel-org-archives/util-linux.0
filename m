Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56887 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751055AbdFXOE4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 10:04:56 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, luto@kernel.org, kzak@redhat.com
Subject: [PATCH 0/5] Ambient capabilities for setpriv
Date: Sat, 24 Jun 2017 16:04:29 +0200
Message-Id: <cover.1498312509.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

this patch series implements support for ambient capabilities in
setpriv(1). Ambient capabilities have been implemented with Linux
4.3 by Andy Lutomirski [1]. Quoting from capabilities(7):

    This is a set of capabilities that are preserved across an
    execve(2) of a program that is not privileged.

The patches are inspired and squarely based on published patches
for util-linux by Andy [2]. As these commits seem to never have
been upstreamed, I've contacted Andy a few days ago whether he
intends to do so in the near future, but got no response. Anyway,
as I would like to have ambient capabilities available in
setpriv, I took up the baton and wrote this patch series.

Regards
Patrick

[1]: https://lwn.net/Articles/636533/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/luto/util-linux-playground.git/commit/?h=cap_ambient&id=860c73ac1acaaae976bdd3bb83b89b0180f0702a

Patrick Steinhardt (5):
  setpriv: introduce indirection for `capng_type` enum
  setpriv: proxy function checking whether a capability is set
  setpriv: proxy function to update capabilities
  setpriv: support dumping ambient capabilities
  setpriv: support modifying the set of ambient capabilities

 sys-utils/setpriv.1 |   8 ++--
 sys-utils/setpriv.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 103 insertions(+), 14 deletions(-)

-- 
2.13.1

