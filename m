Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39479 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752155AbdGQVON (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Jul 2017 17:14:13 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] setpriv: support setting unnamed capabilities
Date: Mon, 17 Jul 2017 23:14:09 +0200
Message-Id: <4ae084e6a1c46726a24057c71d20787680fa3da1.1500326001.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When setting capabilities, we accept human readable names like for
example `sys_rawio` or `net_admin`. To do so the translation between the
capability name and its in-kernel index, we rely on the function
`capng_name_to_capability`. When the function does not know the named
capability, it will return an error value and we abort setting the
capability.

This relies upon the ability of libcap to know all capabilities inside
of the kernel. But actually, it is possible that new capabilities are
introduced inside of the Linux kernel which are not recognized yet by
the library. When dumping these unknown capabilities, libcap will simply
return a string like "cap_38", that is it will append the capability's
in-kernel index to the prefix "cap_". This may lead a user to also think
that "cap_38" may be passed to the switches "--inh-caps" or
"--ambient-caps", which is unfortunately not the case.

We can do better here by instead accepting strings in the form of
"cap_N". To do so, we can simply rely on the fact that capability
indices are steadily increasing and that the highest index known to the
kernel is stored inside of the kernel's procfs, made readily available
by our function `real_cap_last_cap()`. So in case libcap does not know a
capability name, we can simply parse the string and, if it is in the
correct format, check whether the detected index is between 0 and the
highest capability index. If so, we can treat it as a valid capability
string and apply it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/setpriv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 19753aab8..2402e624f 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -529,6 +529,9 @@ static void do_caps(enum cap_type type, const char *caps)
 			int cap = capng_name_to_capability(c + 1);
 			if (0 <= cap)
 				cap_update(action, type, cap);
+			else if (sscanf(c + 1, "cap_%d", &cap) == 1
+			    && 0 <= cap && cap <= real_cap_last_cap())
+				cap_update(action, type, cap);
 			else
 				errx(EXIT_FAILURE,
 				     _("unknown capability \"%s\""), c + 1);
-- 
2.13.3

