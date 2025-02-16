Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C514A60A
	for <util-linux@vger.kernel.org>; Sun, 16 Feb 2025 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739741138; cv=none; b=omic/wYw1lXRX+AJ0oOLwV2pADaQbCyobQ6W9qfaNmX9YpY+WVN4887kT2JFw/39P5L9sa7lGTNb6/982QgTfOmphRuMxXE1wKsxFCT49Bmjk2m6h1McFE7mdNOALaf4t7SK/6G4wnTHQm6xAVCTfpMUKQWALLJYboYvTwqBT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739741138; c=relaxed/simple;
	bh=zx+LiWQNj14nX2KYNUIMYkhBzDTByIpyLQcpxA3rw8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=autwvQZTqqG8U1MLlgjto/5TGB56UOm81xbwf3eBK1KWpI9S0rh7kYG2hWYtKZvz1ZSQz2EtIG6TbLJSrqH1yCj19e4omTY8dCprzIztvxG3vi4lIF+nkSvG+fdxGrts4ccgJFBAocqH4IgOwUOqCdn6QFUDHkDmOVjGcwXfJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i7n8BiN8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XN2uCwz3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qOjYNm/9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ANcFNt4G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i7n8BiN8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XN2uCwz3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qOjYNm/9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ANcFNt4G"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D38AD2115D;
	Sun, 16 Feb 2025 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739741128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L4izpeszk2fYlG4JHxdI5abeRa1K56XEbRPR9/PRcAg=;
	b=i7n8BiN8geRb2NC5R7h979QRDspg7DnFcJty8OgRhCe7HyEL1GL1IntIW9a1WgjnwOuaQr
	ojrp/YapTUG0kYJgknuX7N5odD+gDsazejVG9d6peqkgyW88W7lKStYrrRlkDcO6aYPlCx
	9M/ubMG8410o1lFPe48Su6KZ2H2D5Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739741128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L4izpeszk2fYlG4JHxdI5abeRa1K56XEbRPR9/PRcAg=;
	b=XN2uCwz3+JSYW2iE4XWmEKWm2Gin0Y/cCDHmweV+jXPJR+4GQfmtVhYQLS+/e11p2lKyBT
	oSyZysOb6oEbtBAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739741127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L4izpeszk2fYlG4JHxdI5abeRa1K56XEbRPR9/PRcAg=;
	b=qOjYNm/9c8qEr8IITH1S4Ksb/6ttwYflEAaPkz52C2zfmw6kVRynCQow0xwtYOvW9YbO8Y
	49Oz7w+MUU/DL0nxEhUdI4JzU6MfsHJ3sp2fDp36k9dJteytX4Qssv1G471XS3zhK6lg3S
	9hUCjdXqvY0q7jEtIYryNb1lFdYnpus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739741127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L4izpeszk2fYlG4JHxdI5abeRa1K56XEbRPR9/PRcAg=;
	b=ANcFNt4G8ZgLjs9z0FziUYWp+D/eL0AR3QMAw5oz5cR7PCypwHzAzYGXnc+UBKjXscQULi
	q5FCILcXeS/fWPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C986D13782;
	Sun, 16 Feb 2025 21:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2DjxMMdXsmeBeAAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Sun, 16 Feb 2025 21:25:27 +0000
Received: by goblin.suse.cz (Postfix, from userid 10027)
	id 958B42C0D762; Sun, 16 Feb 2025 22:25:27 +0100 (CET)
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] agetty: Implement netlink based IP address lookup
Date: Sun, 16 Feb 2025 22:24:50 +0100
Message-ID: <20250216212450.61706-1-sbrabec@suse.cz>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

The current implementation of the IP address lookup in agetty is inferior:

The network change watch uses netlink. The netlink message contains all needed
information. But the netlink message is not used at all. To get an IP address
for the \4 and \6 issue file escapes, getifaddrs() is used instead. But
getifaddrs() is inferior to netlink, especially for IPv6. It does not provide
sufficient information to discriminate between an useful global IPv6 address and
an ephemeral IPv6 address that will expire in few seconds. And finally, the
current implementation does not support lookup over all interfaces. External
helpers like issue-generator are needed.

The new netlink based IP address lokup implements a new issue file escape \i.
This lookup is based on netlink messages only. It evaluates all addresses
reported in the netlink messages and it attempts to print only the best of them.
As it is not possible to discriminate the "best" IP address, it reports all
reasonably usable addresses.

To do:

Migrate \4 and \6 from getifaddrs() to netlink as well, and then completely drop
getifaddrs() based code.

It could be useful to implement:
- configurable limit for the maximum number of interfaces that could be
  reported.
- the interface regexp match
- an interface template for fine tuning of the output
- better control over the output: e. g. disable printing of IPv4 or IPv6
  addresses, disable printing of temporary addresses or link-local addresses
- cross-protocol checks: e. g. disable reporting of link-local IPv6 address for
  an IPv4-only interface

Note:

The new network comparison code could potentially render obsolete string based
issue comparison (implemented in 6522d88). There are ifaces_list_change_4 and
ifaces_list_change_6 variables ready for this purpose.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 term-utils/agetty.8.adoc |   3 +
 term-utils/agetty.c      | 405 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 388 insertions(+), 20 deletions(-)

diff --git a/term-utils/agetty.8.adoc b/term-utils/agetty.8.adoc
index 627f858a2..47b4b20c2 100644
--- a/term-utils/agetty.8.adoc
+++ b/term-utils/agetty.8.adoc
@@ -262,6 +262,9 @@ Insert the system name (the name of the operating system). Same as 'uname -s'. S
 S or S{VARIABLE}::
 Insert the VARIABLE data from _/etc/os-release_. If this file does not exist then fall back to _/usr/lib/os-release_. If the VARIABLE argument is not specified, then use PRETTY_NAME from the file or the system name (see \s). This escape code can be used to keep _/etc/issue_ distribution and release independent. Note that \S{ANSI_COLOR} is converted to the real terminal escape sequence.
 
+i::
+Dump usable IPv4 and IPv4 addresses of the all network interfaces. It dumps the global or site IP address, if it exists. If it does not exist, it dumps the temporary interface with the longest lifetime. If it does not exist it dumps the link-local IP address. The IPv6 link-local interface of IPv6 is reported as {IPv6 address}@{interface on a local machine}, but for a real use, the inteface on a local machine needs to be replaced by the interface on a remote machine. To prevent overflooding of the interface dump, the feature automatically disables itself, if the number of usable interfaces exceeds 12.
+
 l::
 Insert the name of the current tty line.
 
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index aa859c27b..fe50a9336 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -146,6 +146,38 @@
 static int inotify_fd = AGETTY_RELOAD_FDNONE;
 static int netlink_fd = AGETTY_RELOAD_FDNONE;
 static uint32_t netlink_groups;
+
+#define BUFSIZE 8192
+
+const int max_ifaces = 12;
+
+/* Network address "quality" */
+enum ip_quality_item_value {
+	IP_QUALITY_SCOPE_UNIVERSE,
+	IP_QUALITY_SCOPE_SITE,
+	IP_QUALITY_IFA_LOCAL,
+	IP_QUALITY_F_TEMPORARY,
+	IP_QUALITY_SCOPE_LINK,
+	IP_QUALITY_BAD
+};
+struct ip_quality_item {
+	enum ip_quality_item_value quality;
+	int len;
+	__u32 ifa_valid; /* IP addres lifetime */
+	struct ip_quality_item *next;
+	char addr[];
+};
+struct iface_quality_item {
+	__u32 ifa_index;
+	struct ip_quality_item *ip_quality_list_4;
+	struct ip_quality_item *ip_quality_list_6;
+	struct iface_quality_item *next;
+};
+static struct iface_quality_item *ifaces_list = NULL;
+bool ifaces_list_change_4;
+bool ifaces_list_change_6;
+bool ifaces_skip_dump = false;
+
 #endif
 
 struct issue {
@@ -351,6 +383,7 @@ FILE *dbf;
 #else
 # define debug(s) do { ; } while (0)
 #endif
+#define debug_net(s) debug("network: " s)
 
 int main(int argc, char **argv)
 {
@@ -1599,7 +1632,9 @@ done:
 }
 
 #ifdef AGETTY_RELOAD
-static void open_netlink(void)
+static int process_netlink_msg(int *triggered, bool wait_for_nlmsg_done);
+static int send_dump_request(int sock_fd);
+static void open_netlink(bool dump_requested)
 {
 	struct sockaddr_nl addr = { 0, };
 	int sock;
@@ -1614,12 +1649,259 @@ static void open_netlink(void)
 		addr.nl_groups = netlink_groups;
 		if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0)
 			close(sock);
-		else
+		else {
 			netlink_fd = sock;
+			if (dump_requested) {
+				send_dump_request(netlink_fd);
+				process_netlink_msg(NULL, true);
+			}
+		}
+	}
+}
+
+static int send_dump_request(int sock_fd) {
+	struct {
+		struct nlmsghdr nh;
+		struct rtgenmsg g;
+	} req;
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(req.g));
+	req.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
+	req.nh.nlmsg_type = RTM_GETADDR;
+	req.g.rtgen_family = AF_UNSPEC;
+
+	return send(sock_fd, &req, req.nh.nlmsg_len, 0);
+}
+
+#ifdef DEBUGGING
+static char *rtattr_ntop(struct ifaddrmsg *ifaddr, struct rtattr *attr) {
+	static char addr_str[INET6_ADDRSTRLEN];
+
+	addr_str[0] = 0;
+	if (ifaddr->ifa_family == AF_INET) {
+		inet_ntop(AF_INET, (struct in_addr *)RTA_DATA(attr), addr_str, sizeof(addr_str));
+	}
+	if (ifaddr->ifa_family == AF_INET6) {
+		inet_ntop(AF_INET6, (struct in_addr6 *)RTA_DATA(attr), addr_str, sizeof(addr_str));
+	}
+	return addr_str;
+}
+#endif
+
+static inline enum ip_quality_item_value evaluate_ip_quality(struct ifaddrmsg *ifaddr) {
+	enum ip_quality_item_value quality;
+	switch (ifaddr->ifa_scope) {
+	case RT_SCOPE_UNIVERSE:
+		debug_net("\tglobal\n");
+		quality = IP_QUALITY_SCOPE_UNIVERSE;
+		break;
+	case RT_SCOPE_LINK:
+		debug_net("\tlink\n");
+		quality = IP_QUALITY_SCOPE_LINK;
+		break;
+	case RT_SCOPE_SITE:
+		debug_net("\tsite\n");
+		quality = IP_QUALITY_SCOPE_SITE;
+		break;
+	default:
+		debug_net("\tother\n");
+		quality = IP_QUALITY_BAD;
+		break;
+	}
+	if (ifaddr->ifa_flags & IFA_F_TEMPORARY) {
+		debug_net("\ttemporary\n");
+		if (quality <= IP_QUALITY_F_TEMPORARY)
+			quality = IP_QUALITY_F_TEMPORARY;
+	}
+	return quality;
+}
+
+static void process_netlink_msg_part(struct nlmsghdr *nh) {
+	struct rtattr *attr;
+	struct ifaddrmsg *ifaddr;
+
+	__u8 family = 0;
+	__u32 valid = 0;
+	enum ip_quality_item_value quality;
+	int len;
+	int addrlen;
+	bool has_local_address = false;
+	int ifaceq_count;
+	void *addr;
+
+	struct iface_quality_item *ifaceq;
+	struct iface_quality_item **ifaceq_prev_next;
+	struct ip_quality_item *ipq;
+	struct ip_quality_item **ipq_prev_next;
+	bool is_newaddr;
+	bool *ifaces_list_change;
+#ifdef DEBUGGING
+	char ifname[IF_NAMESIZE];
+#endif
+
+	if (nh->nlmsg_type != RTM_NEWADDR && nh->nlmsg_type != RTM_DELADDR)
+		return;
+
+	ifaddr = NLMSG_DATA(nh);
+
+#ifdef DEBUGGING
+	fprintf(dbf, "network: interface %d (%s)\n", ifaddr->ifa_index, if_indextoname(ifaddr->ifa_index, ifname)); fflush(dbf);
+#endif
+
+	family = ifaddr->ifa_family;
+#ifdef DEBUGGING
+	if (ifaddr->ifa_family == AF_INET) {
+		debug_net("network: IPv4 ");
+	}
+	if (ifaddr->ifa_family == AF_INET6) {
+		debug_net("network: IPv6 ");
+	}
+#endif
+
+	/* Process rtattr */
+	len = nh->nlmsg_len - NLMSG_LENGTH(sizeof(*ifaddr));
+	if (nh->nlmsg_type == RTM_NEWADDR) {
+		is_newaddr = true;
+	} else {
+		is_newaddr = false;
+	}
+	for (attr = IFA_RTA(ifaddr); RTA_OK(attr, len); attr = RTA_NEXT(attr, len)) {
+		switch (attr->rta_type) {
+		case IFA_ADDRESS:
+#ifdef DEBUGGING
+			fprintf(dbf, "\taddress: %s\n", rtattr_ntop(ifaddr, attr)); fflush(dbf);
+#endif
+			if (!has_local_address) {
+				addr = RTA_DATA(attr);
+				addrlen = RTA_PAYLOAD(attr);
+			}
+			break;
+		case IFA_LOCAL:
+			/* Point to Point interface listens has local address
+			 * and listens there */
+#ifdef DEBUGGING
+			fprintf(dbf, "\tlocal address: %s\n", rtattr_ntop(ifaddr, attr)); fflush(dbf);
+#endif
+			has_local_address = true;
+			addr = RTA_DATA(attr);
+			addrlen = RTA_PAYLOAD(attr);
+			break;
+		case IFA_CACHEINFO: {
+			/* Save lifetime for temporary addresses.
+			   In other cases, lifetime is not authoritative.
+			   The global static address can have a short lifetime
+			   defined by the server. */
+			struct ifa_cacheinfo *ci = (struct ifa_cacheinfo *)RTA_DATA(attr);
+			if (ifaddr->ifa_flags & IFA_F_TEMPORARY) {
+				debug_net("\ttemporary\n");
+				valid = ci->ifa_valid;
+			}}
+			break;
+		}
+	}
+	/* Should not happen */
+	if (addr == NULL) {
+		debug_net("- no address\n");
+		return;
+	}
+	quality = evaluate_ip_quality(ifaddr);
+	if (quality == IP_QUALITY_BAD) {
+		debug_net("- address unusable\n");
+		return;
+	}
+
+	/* Search for interface in ifaces_list */
+	ifaceq = ifaces_list;
+	ifaceq_prev_next = &(ifaces_list);
+	ifaceq_count = 0;
+	while (ifaceq != NULL) {
+		if (ifaceq->ifa_index == ifaddr->ifa_index) {
+			debug_net("+ interface found in the list\n");
+			break;
+		}
+		ifaceq_prev_next = &(ifaceq->next);
+		ifaceq = ifaceq->next;
+		ifaceq_count++;
+	}
+
+	if (ifaceq == NULL) {
+		if (is_newaddr) {
+			if (ifaceq_count >= max_ifaces) {
+				debug_net("+ too many interfaces\n");
+				ifaces_skip_dump = true;
+				return;
+			}
+			debug_net("+ allocating new interface\n");
+			ifaceq = malloc(sizeof(struct iface_quality_item));
+			ifaceq->ifa_index = ifaddr->ifa_index;
+			ifaceq->ip_quality_list_4 = NULL;
+			ifaceq->ip_quality_list_6 = NULL;
+			ifaceq->next = NULL;
+			*ifaceq_prev_next = ifaceq;
+		} else {
+			/* Should never happen */
+			debug_net("- interface not found\n");
+			return;
+		}
+	}
+	if (family == AF_INET) {
+		ipq_prev_next = &(ifaceq->ip_quality_list_4);
+		ifaces_list_change = &ifaces_list_change_4;
+	}
+	if (family == AF_INET6) {
+		ipq_prev_next = &(ifaceq->ip_quality_list_6);
+		ifaces_list_change = &ifaces_list_change_6;
+	}
+	ipq = *ipq_prev_next; /* Equal to: ifaceq->ip_quality_list_(4|6) */
+	while (ipq != NULL && memcmp(ipq->addr, addr, addrlen)) {
+		ipq_prev_next = &(ipq->next);
+		ipq = ipq->next;
+	}
+	if (ipq == NULL) {
+		debug_net("- address not found in the list\n");
+	}
+
+	if (is_newaddr) {
+		struct ip_quality_item *ipq_new;
+
+#ifdef DEBUGGING
+		fprintf(dbf, "network: + new address (addrlen = %d)\n", addrlen); fflush(dbf);
+#endif
+		ipq_new = malloc(sizeof(struct ip_quality_item) + addrlen);
+		ipq_new->quality = quality;
+		ipq_new->len = addrlen;
+		ipq_new->ifa_valid = valid;
+		memcpy(&(ipq_new->addr), addr, addrlen);
+		if (ipq == NULL) {
+			debug_net("+ allocating new address\n");
+			ipq_new->next = NULL;
+			*ifaces_list_change = true;
+		} else {
+			debug_net("+ replacing address data\n");
+			ipq_new->next = ipq->next;
+		}
+		*ipq_prev_next = ipq_new;
+	} else {
+		debug_net("address removed\n");
+		/* Should not happen */
+		if (ipq == NULL)
+			return;
+		/* Delist the address */
+		debug_net("- deleting address\n");
+		*ifaces_list_change = true;
+		*ipq_prev_next = ipq->next;
+		free(ipq);
+		if ((ifaceq->ip_quality_list_4 == NULL) && (ifaceq->ip_quality_list_6 == NULL)) {
+			debug_net("- deleted last IP in the interface, removing interface\n");
+			*ifaceq_prev_next = ifaceq->next;
+			ifaceq_count--;
+			free(ifaceq);
+		}
 	}
 }
 
-static int process_netlink_msg(int *triggered)
+static int process_netlink_msg(int *triggered, bool wait_for_nlmsg_done)
 {
 	char buf[4096];
 	struct sockaddr_nl snl;
@@ -1640,36 +1922,44 @@ static int process_netlink_msg(int *triggered)
 		.msg_flags = 0
 	};
 
-	rc = recvmsg(netlink_fd, &msg, MSG_DONTWAIT);
-	if (rc < 0) {
-		if (errno == EWOULDBLOCK || errno == EAGAIN)
-			return 0;
-
-		/* Failure, just stop listening for changes */
-		close(netlink_fd);
-		netlink_fd = AGETTY_RELOAD_FDNONE;
-		return 0;
-	}
+	while (1) {
+		rc = recvmsg(netlink_fd, &msg, (wait_for_nlmsg_done ? 0 : MSG_DONTWAIT));
+		if (rc < 0) {
+			if (errno == EWOULDBLOCK || errno == EAGAIN)
+				return 0;
 
-	for (h = (struct nlmsghdr *)buf; NLMSG_OK(h, (unsigned int)rc); h = NLMSG_NEXT(h, rc)) {
-		if (h->nlmsg_type == NLMSG_DONE ||
-		    h->nlmsg_type == NLMSG_ERROR) {
+			/* Failure, just stop listening for changes */
 			close(netlink_fd);
 			netlink_fd = AGETTY_RELOAD_FDNONE;
 			return 0;
 		}
 
-		*triggered = 1;
-		break;
+		for (h = (struct nlmsghdr *)buf; NLMSG_OK(h, (unsigned int)rc); h = NLMSG_NEXT(h, rc)) {
+			if (h->nlmsg_type == NLMSG_ERROR) {
+				close(netlink_fd);
+				netlink_fd = AGETTY_RELOAD_FDNONE;
+				return 0;
+			}
+			if (h->nlmsg_type == NLMSG_DONE)
+				goto done;
+			process_netlink_msg_part(h);
+		}
+		if (!wait_for_nlmsg_done) {
+			*triggered = 1;
+			goto done;
+		}
 	}
 
+done:
+	return 0;
+
 	return 1;
 }
 
 static int process_netlink(void)
 {
 	int triggered = 0;
-	while (process_netlink_msg(&triggered));
+	while (process_netlink_msg(&triggered, false));
 	return triggered;
 }
 
@@ -1985,7 +2275,7 @@ done:
 
 #ifdef AGETTY_RELOAD
 	if (netlink_groups != 0)
-		open_netlink();
+		open_netlink(false);
 #endif
 	if (ie->output) {
 		fclose(ie->output);
@@ -2660,6 +2950,73 @@ static void output_iface_ip(struct issue *ie,
 	free(host);
 }
 
+static enum ip_quality_item_value get_quality_limit(struct ip_quality_item *ipq, __u32 *best_valid) {
+	enum ip_quality_item_value qlimit;
+
+	qlimit = IP_QUALITY_BAD;
+	while (ipq != NULL) {
+		if (ipq->ifa_valid > 0) {
+			if (ipq->ifa_valid > *best_valid)
+				*best_valid = ipq->ifa_valid;
+		}
+		if (qlimit > ipq->quality) {
+			qlimit = ipq->quality;
+			/* We do not discriminate between site and global
+			 * addresses. Always report both. */
+			if (qlimit <= IP_QUALITY_SCOPE_SITE)
+				qlimit = IP_QUALITY_SCOPE_SITE;
+		}
+		ipq = ipq->next;
+	}
+	if (qlimit <= IP_QUALITY_SCOPE_SITE)
+		qlimit = IP_QUALITY_SCOPE_SITE;
+	return qlimit;
+}
+
+static void dump_addresses(FILE *out) {
+	struct iface_quality_item *ifaceq;
+	char addr_str[INET6_ADDRSTRLEN];
+
+	ifaceq = ifaces_list;
+	while (ifaceq != NULL) {
+		char ifname[IF_NAMESIZE];
+		enum ip_quality_item_value qlimit;
+		__u32 best_valid;
+		struct ip_quality_item *ipq;
+
+		fprintf(out, "%s:", if_indextoname(ifaceq->ifa_index, ifname));
+		qlimit = get_quality_limit(ifaceq->ip_quality_list_4, &best_valid);
+		best_valid = 0;
+#ifdef DEBUGGING
+		fprintf(dbf, " (quality limit %d)", qlimit); fflush(dbf);
+#endif
+		ipq = ifaceq->ip_quality_list_4;
+		best_valid = 0;
+		while (ipq != NULL) {
+			if (ipq->quality <= qlimit && (best_valid == 0 || ipq->ifa_valid == best_valid))
+				fprintf(out, " %s", inet_ntop(AF_INET, ipq->addr, addr_str, sizeof(addr_str)));
+			ipq = ipq->next;
+		}
+		qlimit = get_quality_limit(ifaceq->ip_quality_list_6, &best_valid);
+		best_valid = 0;
+#ifdef DEBUGGING
+		fprintf(dbf, " (quality limit %d)", qlimit); fflush(dbf);
+#endif
+		ipq = ifaceq->ip_quality_list_6;
+		while (ipq != NULL) {
+			if (ipq->quality <= qlimit && (best_valid == 0 || ipq->ifa_valid == best_valid)) {
+				if (ipq->quality == IP_QUALITY_SCOPE_LINK)
+					fprintf(out, " %s%%%s", inet_ntop(AF_INET6, ipq->addr, addr_str, sizeof(addr_str)), ifname);
+				else
+					fprintf(out, " %s", inet_ntop(AF_INET6, ipq->addr, addr_str, sizeof(addr_str)));
+			}
+			ipq = ipq->next;
+		}
+		fprintf(out, "\n");
+		ifaceq = ifaceq->next;
+	}
+}
+
 /*
  * parses \x{argument}, if not argument specified then returns NULL, the @fd
  * has to point to one char after the sequence (it means '{').
@@ -2876,6 +3233,14 @@ static void output_special_char(struct issue *ie,
 			netlink_groups |= RTMGRP_IPV6_IFADDR;
 		break;
 	}
+	case 'i':
+		netlink_groups |= RTMGRP_IPV4_IFADDR;
+		netlink_groups |= RTMGRP_IPV6_IFADDR;
+		open_netlink(true);
+		dump_addresses(ie->output);
+		ifaces_list_change_4 = false;
+		ifaces_list_change_6 = false;
+		break;
 #endif
 	default:
 		putc(c, ie->output);
-- 
2.48.1

